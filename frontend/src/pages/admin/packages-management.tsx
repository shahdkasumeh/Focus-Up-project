import { useState, useEffect } from "react";
import { motion } from "motion/react";
import { useAuth } from "../../context/GlobalState";
import { ActionTypes } from "../../context/AppReducer";
import { Button } from "../../components/Button";
import {
  packagesApi,
  UpdatePackageData,
  CreatePackageData,
} from "../../APIMethod/packages";
import toast from "react-hot-toast";
import { AddNewPackage } from "./components/AddNewPackage";
import { UpdatePackage } from "./components/UpdatePackage";

import {
  Plus,
  Clock,
  DollarSign,
  Edit2,
  Trash2,
  Check,
  Star,
  TrendingUp,
  Package,
} from "lucide-react";

export function PackagesManagement() {
  const { state, dispatch } = useAuth();
  const { packages } = state;

  const [packageToEdit, setPackageToEdit] = useState(null);
  const [showAddModal, setShowAddModal] = useState(false);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");

  // جلب الباقات
  useEffect(() => {
    fetchPackages();
  }, []);

  const fetchPackages = async () => {
    setLoading(true);
    try {
      const response = await packagesApi.getPackage();
      dispatch({ type: ActionTypes.SET_PACKAGE, payload: response.data });
    } catch (error) {
      console.error("Failed To Retrieve The Packages", error);
      toast.error("Failed To Download The Packages");
    } finally {
      setLoading(false);
    }
  };

  const handleAddPackage = async (packageData: CreatePackageData) => {
    try {
      const loadingToast = toast.loading("The Package Is Being added ...");
      const result = await packagesApi.addPackage(packageData);

      dispatch({ type: ActionTypes.ADD_PACKAGE, payload: result.data });
      setShowAddModal(false);

      toast.success("The package has been successfully added", {
        id: loadingToast,
      });
      await fetchPackages(); // تحديث البيانات
    } catch (error) {
      console.error("Add Failed", error);
      toast.error("Failed To Add The Package");
    }
  };

  const handleUpdatePackage = async (
    packageData: UpdatePackageData,
    packageId: number,
  ) => {
    try {
      const loadingToast = toast.loading("The Package Is Being Modified ...");
      await packagesApi.updatePackage(packageId, packageData);

      dispatch({
        type: ActionTypes.UPDATE_PACKAGE,
        payload: { ...packageData, id: packageId },
      });
      setPackageToEdit(null);

      toast.success("تم تعديل الباقة بنجاح", { id: loadingToast });
      await fetchPackages();
    } catch (error) {
      console.error("Modify Failed", error);
      toast.error("Failed To Modify The Package");
    }
  };

  const handleDeletePackage = async (packageId: number) => {
    try {
      const loadingToast = toast.loading("The Package Is Being Deleted ...");
      await packagesApi.deletePackage(packageId);

      dispatch({ type: ActionTypes.DELETE_PACKAGE, payload: packageId });

      toast.success("The Package Has Been successfully Deleted", {
        id: loadingToast,
      });
    } catch (error) {
      console.error("Delete Failed", error);
      toast.error("Failed To Delete The Package");
    }
  };

  const filteredPackages = packages.filter((thePackage) => {
    const matchesSearch = thePackage.name
      ?.toLowerCase()
      .includes(searchQuery.toLowerCase());
    const matchesStatus =
      filterStatus === "all" ||
      (filterStatus === "active" && thePackage.is_active === 1) ||
      (filterStatus === "inactive" && thePackage.is_active === 0);
    return matchesSearch && matchesStatus;
  });

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl text-gray-900 mb-2">إدارة الباقات</h1>
          <p className="text-gray-600">
            إدارة باقات الاشتراكات الأسبوعية والشهرية
          </p>
        </div>
        <button
          onClick={() => setShowAddModal(true)}
          className="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-[#ffbf1f] to-[#e6ac1c] text-[#034363] rounded-xl hover:shadow-lg transition-all"
        >
          <Plus className="w-5 h-5" />
          إضافة باقة
        </button>
      </div>

      {/* Stats - بدون تغيير */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {/* ... إحصائيات كما هي ... */}
        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
              <Package className="w-6 h-6 text-blue-600" />
            </div>
            <TrendingUp className="w-5 h-5 text-green-500" />
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">{packages.length}</h3>
          <p className="text-gray-600 text-sm">إجمالي الباقات</p>
        </div>

        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center">
              <DollarSign className="w-6 h-6 text-green-600" />
            </div>
            <TrendingUp className="w-5 h-5 text-green-500" />
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">
            {packages.reduce((sum, pkg) => sum + (pkg.subscribers || 0), 0)}
          </h3>
          <p className="text-gray-600 text-sm">إجمالي المشتركين</p>
        </div>

        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center">
              <Star className="w-6 h-6 text-purple-600" />
            </div>
            <TrendingUp className="w-5 h-5 text-green-500" />
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">
            {packages.filter((p) => p.isPopular).length}
          </h3>
          <p className="text-gray-600 text-sm">باقات مميزة</p>
        </div>
      </div>

      {/* Search & Filters - إضافة */}
      <div className="bg-white rounded-2xl shadow-md p-6">
        <div className="flex gap-4">
          <div className="flex-1 relative">
            <input
              type="text"
              placeholder="ابحث عن باقة..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full px-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#ffbf1f]"
            />
          </div>
          <select
            value={filterStatus}
            onChange={(e) => setFilterStatus(e.target.value)}
            className="px-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#ffbf1f]"
          >
            <option value="all">جميع الحالات</option>
            <option value="active">نشطة</option>
            <option value="inactive">غير نشطة</option>
          </select>
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
                eachPackage.isPopular ? "ring-2 ring-[#ffbf1f]" : ""
              }`}
            >
              {/* Package Header */}
              <div className="bg-gradient-to-r from-[#034363] to-[#045a85] p-6">
                <div className="mt-8">
                  <h3 className="text-2xl text-white mb-2 font-bold">
                    {eachPackage.name}
                  </h3>
                  <div className="flex items-baseline gap-2">
                    <span className="text-4xl text-white font-bold">
                      {eachPackage.price}
                    </span>
                    <span className="text-white/80">ليرة سورية</span>
                  </div>
                </div>
              </div>

              {/* Package Details */}
              <div className="p-6 space-y-4 flex-1">
                <div className="flex items-center justify-between pb-4 border-b border-gray-100">
                  <div className="flex items-center gap-2">
                    <Clock className="w-5 h-5 text-[#ffbf1f]" />
                    <span className="text-gray-700 font-medium">
                      {eachPackage.hours} ساعة
                    </span>
                  </div>
                </div>

                <div className="space-y-3">
                  <div className="flex items-center gap-3 group hover:bg-gray-50 p-2 rounded-lg transition-colors">
                    <div className="w-5 h-5 bg-green-100 rounded-full flex items-center justify-center shrink-0">
                      <Check className="w-3 h-3 text-green-600" />
                    </div>
                    <span className="text-gray-700 text-sm">
                      الباقة صالحة لمدة {eachPackage.duration_days} يوم
                    </span>
                  </div>
                  <div className="flex items-center gap-3 group hover:bg-gray-50 p-2 rounded-lg transition-colors">
                    <div className="w-5 h-5 bg-green-100 rounded-full flex items-center justify-center shrink-0">
                      <Check className="w-3 h-3 text-green-600" />
                    </div>
                    <span className="text-gray-700 text-sm">
                      تكلفة الساعة الواحدة {eachPackage.price_per_hour} ليرة
                      سورية
                    </span>
                  </div>
                </div>
              </div>

              <div className="p-6 pt-0">
                <div className="flex gap-2 pt-4 border-t border-gray-100">
                  <Button
                    variant="outline"
                    size="sm"
                    className="flex-1 hover:bg-[#034363] hover:text-white transition-colors"
                    onClick={() => setPackageToEdit(eachPackage)}
                  >
                    <Edit2 className="w-4 h-4 ml-1" />
                    تعديل
                  </Button>
                  <Button
                    variant="outline"
                    size="sm"
                    className="flex-1 text-red-600 border-red-600 hover:bg-red-500 hover:text-white transition-colors"
                    onClick={() => handleDeletePackage(eachPackage.id)}
                  >
                    <Trash2 className="w-4 h-4 ml-1" />
                    حذف
                  </Button>
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      )}

      {showAddModal && (
        <AddNewPackage
          onClose={() => setShowAddModal(false)}
          onAddPackage={handleAddPackage}
        />
      )}

      {packageToEdit && (
        <UpdatePackage
          package={packageToEdit}
          onClose={() => setPackageToEdit(null)}
          onUpdatePackage={handleUpdatePackage}
        />
      )}
    </div>
  );
}
