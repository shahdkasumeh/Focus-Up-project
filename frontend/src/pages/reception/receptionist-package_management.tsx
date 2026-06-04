import { useEffect, useState } from "react";
import { motion } from "motion/react";
import { useAuth } from "../../context/GlobalState";
import { ActionTypes } from "../../context/AppReducer";
import toast from "react-hot-toast";

import { packagesApi } from "../../APIMethod/packages";
import {
  ArrowRight,
  Package,
  AlertCircle,
  CheckCircle2,
  UserRound,
  RefreshCw,
} from "lucide-react";
import { useNavigate } from "react-router-dom";

export function ReceptionistPackageManagement() {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const { state, dispatch } = useAuth();
  const { ReceptionPackages } = state;
  const [searchQuery, setSearchQuery] = useState("");
  const [statusFilter, setStatusFilter] = useState<string>("all");
  const [updatingPackageId, setUpdatingPackageId] = useState<number | null>(
    null,
  );
  const [lastUpdatedPackage, setLastUpdatedPackage] = useState<number | null>(
    null,
  );

  useEffect(() => {
    fetchPackages();
  }, []);

  const fetchPackages = async () => {
    setLoading(true);
    try {
      const response = await packagesApi.getReceptionPackage();
      const packagesData = response.data || [];
      dispatch({
        type: ActionTypes.SET_RECEPTION_PACKAGE,
        payload: packagesData,
      });
      console.log(response);
    } catch (error) {
      console.error(" Failed To Retrieve The Packages", error);
      toast.error("فشل تحميل الباقات");
    } finally {
      setLoading(false);
    }
  };

  const handleBack = () => {
    navigate(-1);
  };

  const togglePackageStatus = async (
    packageId: number,
    currentStatus: string,
  ) => {
    if (updatingPackageId === packageId) return;
    setUpdatingPackageId(packageId);
    const loadingToast = toast.loading("جاري تغيير حالة الباقة...");
    try {
      await packagesApi.updateReceptionPackage(packageId);
      const newStatus = currentStatus === "active" ? "pending" : "active";
      dispatch({
        type: ActionTypes.UPDATE_RECEPTION_PACKAGE,
        payload: { id: packageId, status: newStatus },
      });
      toast.success("تم تغيير الحالة بنجاح", { id: loadingToast });
      setLastUpdatedPackage(packageId);
      await fetchPackages();
    } catch (error) {
      console.error(`Failed to update package ${packageId}:`, error);
      toast.error("فشل تغيير حالة الباقة", { id: loadingToast });
      await fetchPackages();
    } finally {
      setUpdatingPackageId(null);
    }
  };

  const handleManualRefresh = async () => {
    toast.loading("جاري تحديث البيانات...", { id: "refresh" });
    await fetchPackages();
    toast.success("تم تحديث البيانات", { id: "refresh" });
  };

  const activePackages = ReceptionPackages.filter(
    (p) => p.status === "active",
  ).length;
  const pendingPackages = ReceptionPackages.filter(
    (p) => p.status === "pending",
  ).length;
  const totalPackages = ReceptionPackages.length;

  const filteredPackages = ReceptionPackages.filter((thePackage) => {
    const matchesSearch =
      searchQuery === "" ||
      (thePackage.package_name ?? "")
        .toLowerCase()
        .includes(searchQuery.toLowerCase());

    const matchesStatus =
      statusFilter === "all" || thePackage.status === statusFilter;

    return matchesSearch && matchesStatus;
  });

  return (
    <div className="min-h-screen bg-linear-to-br from-blue-50 to-indigo-50">
      {/* Header */}
      <div className="bg-linear-to-br from-[#034363] to-[#045a85] text-white p-6 shadow-lg">
        <div className="max-w-7xl mx-auto">
          <div className="flex items-center justify-between gap-4 mb-6">
            <div className="flex items-center gap-4">
              <button
                onClick={handleBack}
                className="p-2 hover:bg-white/10 rounded-xl transition-colors"
              >
                <ArrowRight className="w-6 h-6" />
              </button>
              <div>
                <h1 className="text-3xl mb-1">إدارة الباقات</h1>
                <p className="text-blue-100">
                  عرض وتحديث حالة باقات الاشتراكات
                </p>
              </div>
            </div>

            <button
              onClick={handleManualRefresh}
              className="p-2 hover:bg-white/10 rounded-xl transition-colors"
              title="تحديث البيانات"
            >
              <RefreshCw className="w-5 h-5" />
            </button>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4">
              <div className="flex items-center justify-between mb-2">
                <Package className="w-5 h-5" />
                <span className="text-2xl font-bold">{totalPackages}</span>
              </div>
              <p className="text-sm text-blue-100">إجمالي الباقات</p>
            </div>
            <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4">
              <div className="flex items-center justify-between mb-2">
                <CheckCircle2 className="w-5 h-5 text-green-300" />
                <span className="text-2xl font-bold text-green-300">
                  {activePackages}
                </span>
              </div>
              <p className="text-sm text-blue-100">باقات فعّالة</p>
            </div>
            <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4">
              <div className="flex items-center justify-between mb-2">
                <AlertCircle className="w-5 h-5 text-yellow-300" />
                <span className="text-2xl font-bold text-yellow-300">
                  {pendingPackages}
                </span>
              </div>
              <p className="text-sm text-blue-100">باقات معلقة</p>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto p-6">
        <div className="mb-6 flex flex-col md:flex-row gap-4">
          <div className="flex-1">
            <input
              type="text"
              placeholder="بحث باسم الباقة..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full px-4 py-2 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#034363]"
            />
          </div>
          <div className="flex gap-2">
            <button
              onClick={() => setStatusFilter("all")}
              className={`px-4 py-2 rounded-xl transition-all ${
                statusFilter === "all"
                  ? "bg-[#034363] text-white"
                  : "bg-white text-gray-700 hover:bg-gray-100"
              }`}
            >
              الكل
            </button>
            <button
              onClick={() => setStatusFilter("active")}
              className={`px-4 py-2 rounded-xl transition-all ${
                statusFilter === "active"
                  ? "bg-green-600 text-white"
                  : "bg-white text-gray-700 hover:bg-gray-100"
              }`}
            >
              فعال
            </button>
            <button
              onClick={() => setStatusFilter("pending")}
              className={`px-4 py-2 rounded-xl transition-all ${
                statusFilter === "pending"
                  ? "bg-yellow-600 text-white"
                  : "bg-white text-gray-700 hover:bg-gray-100"
              }`}
            >
              معلق
            </button>
          </div>
        </div>

        {/* Packages Grid */}
        {loading ? (
          <div className="flex justify-center items-center h-64">
            <div className="text-gray-500">جاري تحميل الباقات...</div>
          </div>
        ) : filteredPackages.length === 0 ? (
          <div className="flex justify-center items-center h-64">
            <div className="text-gray-500">لا توجد باقات مطابقة للبحث</div>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-6">
            {filteredPackages.map((eachPackage, index) => (
              <motion.div
                key={eachPackage.id}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1 }}
                className={`bg-white rounded-2xl shadow-md overflow-hidden hover:shadow-xl transition-all duration-300 flex flex-col h-full ${
                  lastUpdatedPackage === eachPackage.id
                    ? "ring-2 ring-green-500 ring-offset-2"
                    : ""
                }`}
              >
                <div className="bg-linear-to-r from-[#034363] to-[#045a85] p-6">
                  <div className="mt-8">
                    <h3 className="text-2xl text-white mb-2 font-bold">
                      {eachPackage.package_name}
                    </h3>
                  </div>
                </div>

                <div className="p-6 space-y-4 flex-1">
                  <div className="flex items-center justify-between pb-4 border-b border-gray-100">
                    <div className="flex items-center gap-2">
                      <UserRound className="w-5 h-5 text-[#ffbf1f]" />
                      <span className="text-gray-700 font-medium">
                        {eachPackage.user_name}
                      </span>
                    </div>
                    <div
                      className={`px-3 py-1 rounded-full text-xs font-medium transition-all duration-300 ${
                        eachPackage.status === "active"
                          ? "bg-green-100 text-green-700"
                          : "bg-yellow-100 text-yellow-700"
                      }`}
                    >
                      {eachPackage.status === "active" ? " فعال" : " معلق"}
                    </div>
                  </div>
                </div>

                <div className="p-6 pt-0">
                  <div className="pt-4 border-t border-gray-100">
                    <div className="flex items-center justify-between">
                      <span className="text-sm text-gray-700 font-medium">
                        تغيير حالة الباقة
                      </span>
                      <button
                        onClick={() =>
                          togglePackageStatus(
                            eachPackage.id,
                            eachPackage.status,
                          )
                        }
                        disabled={updatingPackageId === eachPackage.id}
                        className={`relative inline-flex items-center gap-2 px-4 py-2 rounded-xl transition-all ${
                          eachPackage.status === "active"
                            ? "bg-green-100 text-green-700 hover:bg-green-200"
                            : "bg-yellow-100 text-yellow-700 hover:bg-yellow-200"
                        } ${updatingPackageId === eachPackage.id ? "opacity-50 cursor-not-allowed" : ""}`}
                      >
                        {updatingPackageId === eachPackage.id ? (
                          <>
                            <div className="w-4 h-4 border-2 border-current border-t-transparent rounded-full animate-spin" />
                            <span className="text-sm font-medium">جاري...</span>
                          </>
                        ) : eachPackage.status === "active" ? (
                          <>
                            <AlertCircle className="w-4 h-4" />
                            <span className="text-sm font-medium">تعليق</span>
                          </>
                        ) : (
                          <>
                            <CheckCircle2 className="w-4 h-4" />
                            <span className="text-sm font-medium">تفعيل</span>
                          </>
                        )}
                      </button>
                    </div>
                  </div>
                </div>
              </motion.div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
