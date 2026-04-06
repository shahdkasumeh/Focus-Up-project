import React, { useState } from "react";
import { motion } from "motion/react";
import {
  QrCode,
  Users,
  Table,
  CheckCircle2,
  XCircle,
  Clock,
  AlertCircle,
  User,
  Settings,
} from "lucide-react";

interface ReceptionistDashboardProps {
  onNavigate: (page: string) => void;
  onLogout: () => void;
}

export function ReceptionistDashboard({
  onNavigate,
  onLogout,
}: ReceptionistDashboardProps) {
  const [stats] = useState({
    activeStudents: 45,
    availableTables: 12,
    reservedTables: 18,
    totalTables: 30,
    todayCheckIns: 67,
    todayCheckOuts: 52,
  });

  const quickActions = [
    {
      id: "scan-checkin",
      title: "مسح QR - تسجيل دخول",
      description: "تفعيل اشتراك الطالب",
      icon: QrCode,
      color: "from-[#ffbf1f] to-[#e6ac1c]",
      textColor: "text-[#034363]",
      action: () => onNavigate("qr-scanner"),
    },
    {
      id: "tables",
      title: "إدارة الطاولات",
      description: "عرض وتحديث حالة الطاولات",
      icon: Table,
      color: "from-[#034363] to-[#045a85]",
      textColor: "text-white",
      action: () => onNavigate("tables"),
    },
    {
      id: "students",
      title: "الطلاب الحاليين",
      description: "عرض الطلاب المتواجدين",
      icon: Users,
      color: "from-[#10B981] to-[#059669]",
      textColor: "text-white",
      action: () => onNavigate("active-students"),
    },
    {
      id: "profile",
      title: "الملف الشخصي",
      description: "إدارة حسابك",
      icon: User,
      color: "from-[#f0f8fc] to-[#e0f2fe]",
      textColor: "text-[#034363]",
      action: () => onNavigate("profile"),
    },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-50">
      {/* Header */}
      <div className="bg-gradient-to-br from-[#034363] to-[#045a85] text-white p-6 shadow-lg">
        <div className="max-w-7xl mx-auto">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h1 className="text-3xl mb-2">لوحة موظف الاستقبال</h1>
              <p className="text-blue-100">مرحباً، أحمد الخالدي</p>
            </div>
            <div className="flex items-center gap-3">
              <button
                onClick={onLogout}
                className="px-4 py-2 bg-white/10 hover:bg-white/20 rounded-xl transition-colors"
              >
                تسجيل الخروج
              </button>
            </div>
          </div>

          {/* Quick Stats */}
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              className="bg-white/10 backdrop-blur-sm rounded-2xl p-4"
            >
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-blue-100 mb-1">الطلاب الحاليين</p>
                  <p className="text-3xl font-bold">{stats.activeStudents}</p>
                </div>
                <div className="w-12 h-12 bg-[#ffbf1f] rounded-xl flex items-center justify-center">
                  <Users className="w-6 h-6 text-[#034363]" />
                </div>
              </div>
            </motion.div>

            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.1 }}
              className="bg-white/10 backdrop-blur-sm rounded-2xl p-4"
            >
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-blue-100 mb-1">طاولات متاحة</p>
                  <p className="text-3xl font-bold">{stats.availableTables}</p>
                </div>
                <div className="w-12 h-12 bg-[#10B981] rounded-xl flex items-center justify-center">
                  <CheckCircle2 className="w-6 h-6 text-white" />
                </div>
              </div>
            </motion.div>

            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.2 }}
              className="bg-white/10 backdrop-blur-sm rounded-2xl p-4"
            >
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-blue-100 mb-1">تسجيلات اليوم</p>
                  <p className="text-3xl font-bold">{stats.todayCheckIns}</p>
                </div>
                <div className="w-12 h-12 bg-[#ffbf1f] rounded-xl flex items-center justify-center">
                  <CheckCircle2 className="w-6 h-6 text-[#034363]" />
                </div>
              </div>
            </motion.div>

            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.3 }}
              className="bg-white/10 backdrop-blur-sm rounded-2xl p-4"
            >
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-blue-100 mb-1">مغادرات اليوم</p>
                  <p className="text-3xl font-bold">{stats.todayCheckOuts}</p>
                </div>
                <div className="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center">
                  <XCircle className="w-6 h-6 text-white" />
                </div>
              </div>
            </motion.div>
          </div>
        </div>
      </div>

      {/* Quick Actions */}
      <div className="max-w-7xl mx-auto p-6">
        <h2 className="text-2xl text-gray-900 mb-6">الإجراءات السريعة</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {quickActions.map((action, index) => (
            <motion.button
              key={action.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              onClick={action.action}
              className="group"
            >
              <div
                className={`bg-gradient-to-br ${action.color} rounded-2xl p-6 shadow-lg hover:shadow-xl transition-all duration-300 hover:scale-105`}
              >
                <div className="flex flex-col items-center text-center">
                  <div
                    className={`w-16 h-16 ${action.textColor === "text-white" ? "bg-white/20" : "bg-[#034363]/10"} rounded-2xl flex items-center justify-center mb-4`}
                  >
                    <action.icon className={`w-8 h-8 ${action.textColor}`} />
                  </div>
                  <h3
                    className={`text-lg font-semibold mb-2 ${action.textColor}`}
                  >
                    {action.title}
                  </h3>
                  <p className={`text-sm ${action.textColor} opacity-80`}>
                    {action.description}
                  </p>
                </div>
              </div>
            </motion.button>
          ))}
        </div>

        {/* Recent Activity */}
        <div className="mt-8">
          <h2 className="text-2xl text-gray-900 mb-6">النشاط الأخير</h2>
          <div className="bg-white rounded-2xl shadow-lg p-6">
            <div className="space-y-4">
              {[
                {
                  name: "محمد أحمد",
                  action: "تسجيل دخول",
                  time: "منذ 5 دقائق",
                  table: "A-12",
                  status: "checkin",
                },
                {
                  name: "فاطمة علي",
                  action: "تسجيل خروج",
                  time: "منذ 12 دقيقة",
                  table: "B-05",
                  status: "checkout",
                },
                {
                  name: "خالد سعيد",
                  action: "تسجيل دخول",
                  time: "منذ 18 دقيقة",
                  table: "C-08",
                  status: "checkin",
                },
                {
                  name: "نورة حسن",
                  action: "تسجيل خروج",
                  time: "منذ 25 دقيقة",
                  table: "A-15",
                  status: "checkout",
                },
              ].map((activity, index) => (
                <motion.div
                  key={index}
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: index * 0.1 }}
                  className="flex items-center justify-between p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition-colors"
                >
                  <div className="flex items-center gap-4">
                    <div
                      className={`w-10 h-10 rounded-xl flex items-center justify-center ${
                        activity.status === "checkin"
                          ? "bg-[#10B981]/10"
                          : "bg-[#034363]/10"
                      }`}
                    >
                      {activity.status === "checkin" ? (
                        <CheckCircle2 className="w-5 h-5 text-[#10B981]" />
                      ) : (
                        <XCircle className="w-5 h-5 text-[#034363]" />
                      )}
                    </div>
                    <div>
                      <p className="text-gray-900 font-medium">
                        {activity.name}
                      </p>
                      <p className="text-sm text-gray-600">
                        {activity.action} - طاولة {activity.table}
                      </p>
                    </div>
                  </div>
                  <div className="flex items-center gap-2 text-gray-500">
                    <Clock className="w-4 h-4" />
                    <span className="text-sm">{activity.time}</span>
                  </div>
                </motion.div>
              ))}
            </div>
          </div>
        </div>

        {/* Table Status Overview */}
        <div className="mt-8">
          <h2 className="text-2xl text-gray-900 mb-6">
            نظرة عامة على الطاولات
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div className="bg-white rounded-2xl shadow-lg p-6">
              <div className="flex items-center justify-between mb-4">
                <h3 className="text-lg font-semibold text-gray-900">متاحة</h3>
                <div className="w-10 h-10 bg-[#10B981]/10 rounded-xl flex items-center justify-center">
                  <CheckCircle2 className="w-5 h-5 text-[#10B981]" />
                </div>
              </div>
              <p className="text-4xl font-bold text-[#10B981] mb-2">
                {stats.availableTables}
              </p>
              <p className="text-sm text-gray-600">
                من أصل {stats.totalTables} طاولة
              </p>
              <div className="mt-4 h-2 bg-gray-100 rounded-full overflow-hidden">
                <div
                  className="h-full bg-[#10B981] rounded-full"
                  style={{
                    width: `${(stats.availableTables / stats.totalTables) * 100}%`,
                  }}
                />
              </div>
            </div>

            <div className="bg-white rounded-2xl shadow-lg p-6">
              <div className="flex items-center justify-between mb-4">
                <h3 className="text-lg font-semibold text-gray-900">محجوزة</h3>
                <div className="w-10 h-10 bg-[#ffbf1f]/10 rounded-xl flex items-center justify-center">
                  <AlertCircle className="w-5 h-5 text-[#ffbf1f]" />
                </div>
              </div>
              <p className="text-4xl font-bold text-[#ffbf1f] mb-2">
                {stats.reservedTables}
              </p>
              <p className="text-sm text-gray-600">
                من أصل {stats.totalTables} طاولة
              </p>
              <div className="mt-4 h-2 bg-gray-100 rounded-full overflow-hidden">
                <div
                  className="h-full bg-[#ffbf1f] rounded-full"
                  style={{
                    width: `${(stats.reservedTables / stats.totalTables) * 100}%`,
                  }}
                />
              </div>
            </div>

            <div className="bg-white rounded-2xl shadow-lg p-6">
              <div className="flex items-center justify-between mb-4">
                <h3 className="text-lg font-semibold text-gray-900">
                  نسبة الإشغال
                </h3>
                <div className="w-10 h-10 bg-[#034363]/10 rounded-xl flex items-center justify-center">
                  <Table className="w-5 h-5 text-[#034363]" />
                </div>
              </div>
              <p className="text-4xl font-bold text-[#034363] mb-2">
                {Math.round((stats.reservedTables / stats.totalTables) * 100)}%
              </p>
              <p className="text-sm text-gray-600">معدل الاستخدام الحالي</p>
              <div className="mt-4 h-2 bg-gray-100 rounded-full overflow-hidden">
                <div
                  className="h-full bg-[#034363] rounded-full"
                  style={{
                    width: `${(stats.reservedTables / stats.totalTables) * 100}%`,
                  }}
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
