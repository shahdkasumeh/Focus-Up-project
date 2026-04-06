import React, { useState } from "react";
import { motion } from "motion/react";
import { Button } from "../../components/Button";
import { Input } from "../../components/Input";
import {
  Plus,
  Search,
  Edit2,
  Trash2,
  MapPin,
  Users,
  DollarSign,
  Star,
  Upload,
  X,
} from "lucide-react";

const rooms = [
  {
    id: 1,
    name: "قاعة النجاح",
    capacity: 30,
    rating: 4.8,
    status: "active",
  },
  {
    id: 2,
    name: "قاعة الإبداع",
    capacity: 30,
    rating: 4.9,
    status: "active",
  },
  {
    id: 3,
    name: "قاعة الهدوء",
    capacity: 30,
    rating: 4.7,
    status: "active",
  },
  {
    id: 4,
    name: "قاعة التفوق",
    capacity: 30,
    rating: 4.8,
    status: "inactive",
  },
];

export function RoomsManagement() {
  const [searchQuery, setSearchQuery] = useState("");
  const [showAddModal, setShowAddModal] = useState(false);
  const [formData, setFormData] = useState({
    name: "",
    center: "",
    capacity: "",
    price: "",
    amenities: "",
  });
  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl text-gray-900 mb-2">إدارة القاعات</h1>
          <p className="text-gray-600">إضافة وتعديل وحذف القاعات الدراسية</p>
        </div>
        <Button variant="primary" onClick={() => setShowAddModal(true)}>
          <Plus className="w-5 h-5 ml-2" />
          إضافة قاعة جديدة
        </Button>
      </div>

      {/* Search & Filters */}
      <div className="bg-white rounded-2xl shadow-md p-6">
        <div className="flex gap-4">
          <div className="flex-1 relative">
            <Search className="absolute right-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="ابحث عن قاعة..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-4 pr-11 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#ffbf1f]"
            />
          </div>
          <select className="px-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#ffbf1f]">
            <option>جميع الحالات</option>
            <option>نشطة</option>
            <option>غير نشطة</option>
          </select>
        </div>
      </div>

      {/* Rooms Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {rooms.map((room, index) => (
          <motion.div
            key={room.id}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: index * 0.1 }}
            className="bg-white rounded-2xl shadow-md overflow-hidden hover:shadow-lg transition-shadow"
          >
            {/* Image */}
            <div className="h-40 bg-gradient-to-br from-blue-100 to-indigo-100 relative flex items-center justify-center">
              <MapPin className="w-16 h-16 text-[#2563EB] opacity-30" />
            </div>

            {/* Content */}
            <div className="p-5">
              <div className="flex items-start justify-between mb-3">
                <div>
                  <h3 className="text-lg text-gray-900 mb-1">{room.name}</h3>
                </div>
                <div
                  className={`px-2 py-0.5 rounded-full text-xs  ${
                    room.status === "active"
                      ? "bg-[#10B981] text-white"
                      : "bg-gray-400 text-white"
                  }`}
                >
                  {room.status === "active" ? "نشط" : "غير نشط"}
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3 mb-4">
                <div className="flex items-center gap-2 text-sm text-gray-600">
                  <Users className="w-4 h-4" />
                  {room.capacity} مقعد
                </div>
              </div>

              <div className="flex gap-2 pt-4 border-t border-gray-100">
                <Button variant="outline" size="sm" className="flex-1">
                  <Edit2 className="w-4 h-4 ml-1" />
                  تعديل
                </Button>
                <Button variant="danger" size="sm" className="flex-1">
                  <Trash2 className="w-4 h-4 ml-1" />
                  حذف
                </Button>
              </div>
            </div>
          </motion.div>
        ))}
      </div>

      {/* Add Room Modal */}
      {showAddModal && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-6"
          onClick={() => setShowAddModal(false)}
        >
          <motion.div
            initial={{ scale: 0.9, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            onClick={(e) => e.stopPropagation()}
            className="bg-white rounded-2xl shadow-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto"
          >
            <div className="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex items-center justify-between">
              <h2 className="text-2xl text-gray-900">إضافة قاعة جديدة</h2>
              <button
                onClick={() => setShowAddModal(false)}
                className="w-10 h-10 rounded-xl hover:bg-gray-100 flex items-center justify-center transition-colors"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <div className="p-6 space-y-5">
              {/* Upload Image */}
              <div>
                <label className="block text-sm text-gray-700 mb-2">
                  صورة القاعة
                </label>
                <div className="border-2 border-dashed border-gray-300 rounded-xl p-8 text-center hover:border-[#2563EB] transition-colors cursor-pointer">
                  <Upload className="w-12 h-12 mx-auto mb-3 text-gray-400" />
                  <p className="text-gray-600 mb-1">اسحب وأفلت الصورة هنا</p>
                  <p className="text-sm text-gray-500">أو انقر للتصفح</p>
                </div>
              </div>

              <Input
                label="اسم القاعة"
                placeholder="مثال: قاعة النجاح"
                value={formData.name}
                onChange={(e) =>
                  setFormData({ ...formData, name: e.target.value })
                }
              />

              <div className="grid grid-cols-2 gap-6">
                <div className="space-y-2">
                  <label
                    htmlFor="status-select"
                    className="block text-sm font-medium text-gray-700"
                  >
                    حالة القاعة
                  </label>
                  <select
                    id="status-select"
                    className="w-full px-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#ffbf1f] focus:border-transparent"
                  >
                    <option>نشطة</option>
                    <option>غير نشطة</option>
                  </select>
                </div>

                <div className="space-y-2">
                  <label className="block text-sm font-medium text-gray-700">
                    السعة{" "}
                  </label>
                  <Input
                    type="number"
                    placeholder="15"
                    value={formData.price}
                    onChange={(e) =>
                      setFormData({ ...formData, price: e.target.value })
                    }
                    className="w-full"
                  />
                </div>
              </div>

              <div className="flex gap-3 pt-4">
                <Button
                  variant="outline"
                  className="flex-1"
                  onClick={() => setShowAddModal(false)}
                >
                  إلغاء
                </Button>
                <Button
                  variant="primary"
                  className="flex-1"
                  onClick={() => setShowAddModal(false)}
                >
                  <Plus className="w-5 h-5 ml-2" />
                  إضافة القاعة
                </Button>
              </div>
            </div>
          </motion.div>
        </motion.div>
      )}
    </div>
  );
}
