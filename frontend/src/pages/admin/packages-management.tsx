import React, { useState } from "react";
import { motion } from "motion/react";
import {
  Package,
  Plus,
  Clock,
  Calendar,
  DollarSign,
  Edit2,
  Trash2,
  Check,
  Star,
  TrendingUp,
} from "lucide-react";

interface PackageItem {
  id: string;
  name: string;
  type: "weekly" | "monthly";
  price: number;
  hours: number;
  features: string[];
  isPopular?: boolean;
  subscribers: number;
}

export function PackagesManagement() {
  const [showAddModal, setShowAddModal] = useState(false);
  const [packages, setPackages] = useState<PackageItem[]>([
    {
      id: "1",
      name: "الباقة الأسبوعية الأساسية",
      type: "weekly",
      price: 50,
      hours: 20,
      features: ["20 ساعة أسبوعياً", "واي فاي مجاني", "قهوة مجانية"],
      subscribers: 45,
    },
    {
      id: "2",
      name: "الباقة الأسبوعية المتقدمة",
      type: "weekly",
      price: 80,
      hours: 35,
      features: [
        "35 ساعة أسبوعياً",
        "واي فاي مجاني",
        "قهوة مجانية",
        "غرفة اجتماعات",
      ],
      isPopular: true,
      subscribers: 78,
    },
    {
      id: "3",
      name: "الباقة الشهرية الأساسية",
      type: "monthly",
      price: 150,
      hours: 80,
      features: [
        "80 ساعة شهرياً",
        "واي فاي مجاني",
        "قهوة مجانية",
        "خزانة خاصة",
      ],
      subscribers: 32,
    },
    {
      id: "4",
      name: "الباقة الشهرية الذهبية",
      type: "monthly",
      price: 250,
      hours: 150,
      features: [
        "150 ساعة شهرياً",
        "واي فاي مجاني",
        "قهوة مجانية",
        "خزانة خاصة",
        "غرفة اجتماعات",
        "أولوية في الحجز",
      ],
      isPopular: true,
      subscribers: 56,
    },
  ]);

  const getTypeColor = (type: string) => {
    return type === "weekly"
      ? "bg-blue-100 text-blue-700 border-blue-200"
      : "bg-purple-100 text-purple-700 border-purple-200";
  };

  const getTypeText = (type: string) => {
    return type === "weekly" ? "أسبوعية" : "شهرية";
  };

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

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
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
            {packages.reduce((sum, pkg) => sum + pkg.subscribers, 0)}
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

      {/* Packages Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-6">
        {packages.map((pkg, index) => (
          <motion.div
            key={pkg.id}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: index * 0.1 }}
            className={`bg-white rounded-2xl shadow-md overflow-hidden hover:shadow-xl transition-shadow ${
              pkg.isPopular ? "ring-2 ring-[#ffbf1f]" : ""
            }`}
          >
            {/* Package Header */}
            <div
              className={`${
                pkg.isPopular
                  ? "bg-gradient-to-r from-[#ffbf1f] to-[#e6ac1c]"
                  : "bg-gradient-to-r from-[#034363] to-[#045a85]"
              } p-6 relative`}
            >
              {pkg.isPopular && (
                <div className="absolute top-4 left-4 flex items-center gap-2 px-3 py-1 bg-white/20 backdrop-blur-sm rounded-lg">
                  <Star className="w-4 h-4 text-white" />
                  <span className="text-sm text-white">الأكثر شعبية</span>
                </div>
              )}

              <div className="mt-8">
                <h3 className="text-2xl text-white mb-2">{pkg.name}</h3>
                <div className="flex items-baseline gap-2">
                  <span className="text-4xl text-white">{pkg.price}</span>
                  <span className="text-white/80">ريال</span>
                  <span className="text-white/60 text-sm">
                    / {getTypeText(pkg.type)}
                  </span>
                </div>
              </div>
            </div>

            {/* Package Details */}
            <div className="p-6 space-y-4">
              <div className="flex items-center justify-between pb-4 border-b border-gray-100">
                <div className="flex items-center gap-2">
                  <Clock className="w-5 h-5 text-[#ffbf1f]" />
                  <span className="text-gray-700">{pkg.hours} ساعة</span>
                </div>
                <span
                  className={`px-3 py-1 rounded-lg text-sm border ${getTypeColor(pkg.type)}`}
                >
                  {getTypeText(pkg.type)}
                </span>
              </div>

              {/* Features */}
              <div className="space-y-3">
                {pkg.features.map((feature, idx) => (
                  <div key={idx} className="flex items-center gap-3">
                    <div className="w-5 h-5 bg-green-100 rounded-full flex items-center justify-center shrink-0">
                      <Check className="w-3 h-3 text-green-600" />
                    </div>
                    <span className="text-gray-700 text-sm">{feature}</span>
                  </div>
                ))}
              </div>

              {/* Subscribers */}
              <div className="pt-4 border-t border-gray-100">
                <div className="flex items-center justify-between text-sm text-gray-600 mb-2">
                  <span>عدد المشتركين</span>
                  <span className="text-[#034363]">
                    {pkg.subscribers} مشترك
                  </span>
                </div>
                <div className="h-2 bg-gray-200 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-gradient-to-r from-[#ffbf1f] to-[#e6ac1c]"
                    style={{
                      width: `${Math.min((pkg.subscribers / 100) * 100, 100)}%`,
                    }}
                  />
                </div>
              </div>
            </div>

            {/* Actions */}
            <div className="p-4 bg-gray-50 border-t border-gray-100 flex gap-2">
              <button className="flex-1 flex items-center justify-center gap-2 px-4 py-2 bg-[#034363] text-white rounded-xl hover:bg-[#045a85] transition-colors">
                <Edit2 className="w-4 h-4" />
                تعديل
              </button>
              <button className="flex items-center justify-center gap-2 px-4 py-2 bg-red-50 text-red-600 rounded-xl hover:bg-red-100 transition-colors">
                <Trash2 className="w-4 h-4" />
              </button>
            </div>
          </motion.div>
        ))}
      </div>

      {/* Add Package Modal */}
      {showAddModal && (
        <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-6">
          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            className="bg-white rounded-2xl shadow-2xl max-w-2xl w-full p-8 max-h-[90vh] overflow-y-auto"
          >
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-2xl text-gray-900">إضافة باقة جديدة</h2>
              <button
                onClick={() => setShowAddModal(false)}
                className="w-10 h-10 bg-gray-100 hover:bg-gray-200 rounded-xl flex items-center justify-center transition-colors"
              >
                ✕
              </button>
            </div>

            <form className="space-y-4">
              <div>
                <label className="block text-sm text-gray-700 mb-2">
                  اسم الباقة
                </label>
                <input
                  type="text"
                  className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none"
                  placeholder="مثال: الباقة الأسبوعية الذهبية"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm text-gray-700 mb-2">
                    نوع الباقة
                  </label>
                  <select className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none">
                    <option value="weekly">أسبوعية</option>
                    <option value="monthly">شهرية</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm text-gray-700 mb-2">
                    السعر (ريال)
                  </label>
                  <input
                    type="number"
                    className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none"
                    placeholder="150"
                  />
                </div>
              </div>

              <div>
                <label className="block text-sm text-gray-700 mb-2">
                  عدد الساعات
                </label>
                <input
                  type="number"
                  className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none"
                  placeholder="80"
                />
              </div>

              <div>
                <label className="flex items-center gap-2 cursor-pointer">
                  <input
                    type="checkbox"
                    className="w-5 h-5 rounded border-gray-300"
                  />
                  <span className="text-sm text-gray-700">
                    تعيين كباقة مميزة
                  </span>
                </label>
              </div>

              <div className="flex gap-3 pt-4">
                <button
                  type="button"
                  onClick={() => setShowAddModal(false)}
                  className="flex-1 px-6 py-3 bg-gray-100 text-gray-700 rounded-xl hover:bg-gray-200 transition-colors"
                >
                  إلغاء
                </button>
                <button
                  type="submit"
                  className="flex-1 px-6 py-3 bg-gradient-to-r from-[#ffbf1f] to-[#e6ac1c] text-[#034363] rounded-xl hover:shadow-lg transition-all"
                >
                  إضافة الباقة
                </button>
              </div>
            </form>
          </motion.div>
        </div>
      )}
    </div>
  );
}
