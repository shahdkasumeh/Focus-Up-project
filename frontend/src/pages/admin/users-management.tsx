import React, { useState } from "react";
import { motion } from "motion/react";
import {
  Search,
  UserPlus,
  MoreVertical,
  Mail,
  Phone,
  Calendar,
  DollarSign,
  Ban,
  CheckCircle,
} from "lucide-react";
import { Button } from "../../components/Button";

const users = [
  {
    id: 1,
    name: "أحمد محمد",
    email: "ahmed@example.com",
    phone: "0501234567",
    joinDate: "2025-12-15",
    totalBookings: 24,
    activeBookings: 3,
    totalSpent: 1240,
    status: "active",
  },
  {
    id: 2,
    name: "سارة أحمد",
    email: "sara@example.com",
    phone: "0509876543",
    joinDate: "2026-01-10",
    totalBookings: 12,
    activeBookings: 1,
    totalSpent: 680,
    status: "active",
  },
  {
    id: 3,
    name: "محمد علي",
    email: "mohammed@example.com",
    phone: "0555555555",
    joinDate: "2025-11-20",
    totalBookings: 35,
    activeBookings: 2,
    totalSpent: 1890,
    status: "active",
  },
  {
    id: 4,
    name: "فاطمة خالد",
    email: "fatima@example.com",
    phone: "0544444444",
    joinDate: "2026-02-01",
    totalBookings: 8,
    activeBookings: 0,
    totalSpent: 420,
    status: "inactive",
  },
  {
    id: 5,
    name: "خالد سعيد",
    email: "khalid@example.com",
    phone: "0533333333",
    joinDate: "2025-10-05",
    totalBookings: 42,
    activeBookings: 4,
    totalSpent: 2150,
    status: "active",
  },
];

export function UsersManagement() {
  const [searchQuery, setSearchQuery] = useState("");
  const [statusFilter, setStatusFilter] = useState("all");

  const filteredUsers =
    statusFilter === "all"
      ? users
      : users.filter((u) => u.status === statusFilter);

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl text-gray-900 mb-2">إدارة المستخدمين</h1>
          <p className="text-gray-600">عرض وإدارة المستخدمين المسجلين</p>
        </div>
        <Button variant="primary">
          <UserPlus className="w-5 h-5 ml-2" />
          إضافة مستخدم
        </Button>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="bg-gradient-to-br from-[#2563EB] to-[#1d4ed8] text-white rounded-xl shadow-md p-5">
          <p className="text-sm opacity-90 mb-1">إجمالي المستخدمين</p>
          <p className="text-3xl">{users.length}</p>
        </div>
        <div className="bg-gradient-to-br from-[#10B981] to-[#059669] text-white rounded-xl shadow-md p-5">
          <p className="text-sm opacity-90 mb-1">نشطين</p>
          <p className="text-3xl">
            {users.filter((u) => u.status === "active").length}
          </p>
        </div>
        <div className="bg-gradient-to-br from-[#F59E0B] to-[#d97706] text-white rounded-xl shadow-md p-5">
          <p className="text-sm opacity-90 mb-1">إجمالي الحجوزات</p>
          <p className="text-3xl">
            {users.reduce((acc, u) => acc + u.totalBookings, 0)}
          </p>
        </div>
        <div className="bg-gradient-to-br from-purple-600 to-purple-700 text-white rounded-xl shadow-md p-5">
          <p className="text-sm opacity-90 mb-1">إجمالي الإيرادات</p>
          <p className="text-3xl">
            {users.reduce((acc, u) => acc + u.totalSpent, 0)} ر.س
          </p>
        </div>
      </div>

      {/* Search & Filters */}
      <div className="bg-white rounded-2xl shadow-md p-6">
        <div className="flex gap-4">
          <div className="flex-1 relative">
            <Search className="absolute right-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="ابحث باسم المستخدم أو البريد الإلكتروني..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-4 pr-11 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#2563EB]"
            />
          </div>
          <select
            className="px-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#2563EB]"
            value={statusFilter}
            onChange={(e) => setStatusFilter(e.target.value)}
          >
            <option value="all">جميع المستخدمين</option>
            <option value="active">نشطين</option>
            <option value="inactive">غير نشطين</option>
          </select>
        </div>
      </div>

      {/* Users Table */}
      <div className="bg-white rounded-2xl shadow-md overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  المستخدم
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  معلومات الاتصال
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  تاريخ التسجيل
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  عدد الحجوزات
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  الحجوزات النشطة
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  إجمالي الإنفاق
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  الحالة
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  الإجراءات
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200">
              {filteredUsers.map((user, index) => (
                <motion.tr
                  key={user.id}
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ delay: index * 0.05 }}
                  className="hover:bg-gray-50 transition-colors"
                >
                  <td className="px-6 py-4">
                    <div className="flex items-center gap-3">
                      <div className="w-10 h-10 bg-gradient-to-br from-[#2563EB] to-[#1d4ed8] rounded-xl flex items-center justify-center text-white text-sm">
                        {user.name.charAt(0)}
                      </div>
                      <div>
                        <p className="text-sm text-gray-900">{user.name}</p>
                        <p className="text-xs text-gray-500">ID: #{user.id}</p>
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <div className="space-y-1">
                      <div className="flex items-center gap-2 text-sm text-gray-700">
                        <Mail className="w-4 h-4 text-gray-400" />
                        {user.email}
                      </div>
                      <div className="flex items-center gap-2 text-sm text-gray-700">
                        <Phone className="w-4 h-4 text-gray-400" />
                        {user.phone}
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex items-center gap-2 text-sm text-gray-700">
                      <Calendar className="w-4 h-4 text-gray-400" />
                      {user.joinDate}
                    </div>
                  </td>
                  <td className="px-6 py-4 text-center">
                    <span className="inline-flex items-center justify-center w-10 h-10 bg-blue-50 text-[#2563EB] rounded-xl">
                      {user.totalBookings}
                    </span>
                  </td>
                  <td className="px-6 py-4 text-center">
                    <span className="inline-flex items-center justify-center w-10 h-10 bg-green-50 text-[#10B981] rounded-xl">
                      {user.activeBookings}
                    </span>
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex items-center gap-2 text-sm text-[#2563EB]">
                      <DollarSign className="w-4 h-4" />
                      {user.totalSpent} ر.س
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <span
                      className={`inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs ${
                        user.status === "active"
                          ? "bg-[#10B981]/10 text-[#10B981]"
                          : "bg-gray-100 text-gray-600"
                      }`}
                    >
                      {user.status === "active" ? (
                        <>
                          <CheckCircle className="w-3.5 h-3.5" />
                          نشط
                        </>
                      ) : (
                        <>
                          <Ban className="w-3.5 h-3.5" />
                          غير نشط
                        </>
                      )}
                    </span>
                  </td>
                  <td className="px-6 py-4">
                    <button className="p-2 hover:bg-gray-100 rounded-lg transition-colors">
                      <MoreVertical className="w-5 h-5 text-gray-600" />
                    </button>
                  </td>
                </motion.tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
