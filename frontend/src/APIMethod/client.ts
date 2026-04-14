import axios from "axios";

// إنشاء نسخة من Axios مع الإعدادات الأساسية
const apiClient = axios.create({
  baseURL: "http://localhost:8000/api",
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
  },
});

// ✅ Interceptor 1: يضيف التوكن تلقائياً قبل كل طلب
apiClient.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem("token");
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
      console.log("✅ Token added to request:", config.url);
    } else {
      console.warn("⚠️ No token found for:", config.url);
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  },
);

// ✅ Interceptor 2: يعالج الأخطاء تلقائياً (مثل انتهاء التوكن)
apiClient.interceptors.response.use(
  (response) => {
    // الطلب ناجح
    return response;
  },
  (error) => {
    if (error.response?.status === 401) {
      // التوكن منتهي أو غير صالح
      console.error("❌ Unauthorized! Logging out...");
      localStorage.removeItem("token");
      localStorage.removeItem("user");
      window.location.href = "/login";
    } else if (error.response?.status === 405) {
      console.error("❌ Method not allowed:", error.config?.url);
    } else if (error.response?.status === 422) {
      console.error("❌ Validation error:", error.response?.data);
    }

    return Promise.reject(error);
  },
);

// دالة مساعدة لتحويل استجابة Axios إلى الشكل الذي اعتدت عليه
async function request<T>(
  endpoint: string,
  method: string = "GET",
  data?: any,
): Promise<T> {
  try {
    const response = await apiClient.request({
      url: endpoint,
      method,
      data,
    });

    // Axios يضع البيانات في response.data
    return response.data as T;
  } catch (error) {
    console.error(`❌ Request failed: ${method} ${endpoint}`, error);
    throw error;
  }
}

// نفس الـ API الذي كنت تستخدمه - لا تحتاج لتغيير أي شيء في باقي الملفات!
export const api = {
  get: <T>(endpoint: string) => request<T>(endpoint, "GET"),
  post: <T>(endpoint: string, data: any) => request<T>(endpoint, "POST", data),
  put: <T>(endpoint: string, data: any) => request<T>(endpoint, "PUT", data),
  delete: <T>(endpoint: string) => request<T>(endpoint, "DELETE"),
};

// تصدير apiClient أيضاً للاستخدام المباشر إذا احتجته
export { apiClient };
