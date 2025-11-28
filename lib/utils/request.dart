
import 'package:bakersoccer/utils/tokenStorage/tokenStorage.dart';
import 'package:dio/dio.dart';

import 'log.dart';

/// 请求方法:枚举类型
enum DioMethod {
  get,
  post,
  put,
  delete,
  patch,
  head,
}

// 创建请求类：封装dio
class Request {
  /// 单例模式
  static Request? _instance;

  // 工厂函数：执行初始化
  factory Request() => _instance ?? Request._internal();

  // 获取实例对象时，如果有实例对象就返回，没有就初始化
  static Request? get instance => _instance ?? Request._internal();

  /// Dio实例
  static Dio _dio = Dio();
  /// 初始化
  Request._internal() {
    // 初始化基本选项
    BaseOptions options = BaseOptions(
        baseUrl: 'http://baker.server.launchever.cn',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5));
    _instance = this;
    // 初始化dio
    _dio = Dio(options);
    // 添加拦截器
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
  }

  // 解析FormData为字符串（便于打印）
  String _formDataToString(FormData formData) {
    final buffer = StringBuffer();
    // 打印普通字段（键值对）
    if (formData.fields.isNotEmpty) {
      buffer.write("{");
      for (final field in formData.fields) {
        buffer.write("${field.key}: ${field.value}, ");
      }
      buffer.write("}");
    }

    // 打印文件字段（如果有文件上传）
    if (formData.files.isNotEmpty) {
      buffer.write("files: {");
      for (final file in formData.files) {
        buffer.write("${file.key}: ${file.value}");
      }
      buffer.write("}");
    }

    buffer.write(")");
    return buffer.toString();
  }

  /// 请求拦截器
  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // // 动态获取Token
    String? token = await TokenStorage.getAccessToken();
    // 如果Token存在，则将其添加到请求头中
    options.headers["Authorization"] = "Bearer $token";
    // 处理body打印
    String bodyStr;
    if (options.data is FormData) {
      // 如果是FormData，调用工具方法解析
      bodyStr = _formDataToString(options.data as FormData);
    } else {
      // 其他类型直接toString()
      bodyStr = options.data.toString();
    }
    // 继续执行请求
    print("Request to: ${options.uri} === Headers: ${options.headers} === Body: ${bodyStr}");
    handler.next(options);
    // super.onRequest(options, handler);
  }

  /// 响应拦截器
  void _onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // 请求成功是对数据做基本处理
    if (response.statusCode == 200) {
      // 处理成功的响应
      // print("响应结果: $response");
    } else {
      // 处理异常结果
      print("响应异常: $response");
    }
    handler.next(response);
  }

  /// 错误处理: 网络错误等
  void _onError(DioException error, ErrorInterceptorHandler handler) {
    handler.next(error);
  }

  /// 请求类：支持异步请求操作  dio会自动设置设置请求类型
  Future<T> request<T>(
      String path, {
        DioMethod method = DioMethod.get,
        Map<String, dynamic>? params,
        dynamic data,
        CancelToken? cancelToken,
        Options? options,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    const _methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head'
    };
    // 默认配置选项
    options ??= Options(method: _methodValues[method]);
    // 处理请求体：将data转换为FormData（适用于有请求体的方法）
    dynamic formData;
    if (data != null) {
      // 仅对POST/PUT/PATCH等需要请求体的方法转换为FormData
      if ([DioMethod.post, DioMethod.put, DioMethod.patch].contains(method)) {
        formData = FormData.fromMap(data); // 核心：转换为FormData
      } else {
        formData = data; // GET/DELETE等方法无需FormData，直接使用原始data
      }
    } else {
      formData = data;
    }
    try {
      Response response;
      // 开始发送请求
      response = await _dio.request(path,
          data: formData,
          queryParameters: params, // URL参数（get请求的参数放这里）
          cancelToken: cancelToken,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } on DioException catch (e) {
      log.e("发送请求异常: ${e.response}");
      rethrow;
    }
  }

  /// 开启日志打印
  /// 需要打印日志的接口在接口请求前 Request.instance?.openLog();
  void openLog() {
    _dio.interceptors
        .add(LogInterceptor(responseHeader: false, responseBody: true));
  }
}