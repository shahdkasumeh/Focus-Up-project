import React, { useState } from "react";
import { motion } from "motion/react";
import {
  ArrowRight,
  Table,
  CheckCircle2,
  XCircle,
  AlertCircle,
  User,
  Clock,
  Edit,
  Search,
  Filter,
} from "lucide-react";
import { Button } from "../../components/Button";
import { useNavigate } from "react-router-dom";

interface TablesManagementProps {
  onBack: () => void;
}

type TableStatus = "available" | "occupied" | "reserved" | "maintenance";

interface TableData {
  id: string;
  name: string;
  section: string;
  status: TableStatus;
  capacity: number;
  studentName?: string;
  checkInTime?: string;
  reservedUntil?: string;
}

export function ReceptionTablesManagement() {
  const navigate = useNavigate();

  const [searchQuery, setSearchQuery] = useState("");
  const [filterStatus, setFilterStatus] = useState<TableStatus | "all">("all");
  const [selectedTable, setSelectedTable] = useState<TableData | null>(null);

  const [tables] = useState<TableData[]>([
    {
      id: "A-01",
      name: "A-01",
      section: "القسم A",
      status: "available",
      capacity: 1,
    },
    {
      id: "A-02",
      name: "A-02",
      section: "القسم A",
      status: "occupied",
      capacity: 1,
      studentName: "محمد أحمد",
      checkInTime: "09:30",
    },
    {
      id: "A-03",
      name: "A-03",
      section: "القسم A",
      status: "available",
      capacity: 1,
    },
    {
      id: "A-04",
      name: "A-04",
      section: "القسم A",
      status: "reserved",
      capacity: 1,
      reservedUntil: "14:00",
    },
    {
      id: "A-05",
      name: "A-05",
      section: "القسم A",
      status: "occupied",
      capacity: 1,
      studentName: "فاطمة علي",
      checkInTime: "08:45",
    },
    {
      id: "B-01",
      name: "B-01",
      section: "القسم B",
      status: "available",
      capacity: 2,
    },
    {
      id: "B-02",
      name: "B-02",
      section: "القسم B",
      status: "maintenance",
      capacity: 2,
    },
    {
      id: "B-03",
      name: "B-03",
      section: "القسم B",
      status: "occupied",
      capacity: 2,
      studentName: "خالد سعيد",
      checkInTime: "10:15",
    },
    {
      id: "B-04",
      name: "B-04",
      section: "القسم B",
      status: "available",
      capacity: 2,
    },
    {
      id: "C-01",
      name: "C-01",
      section: "القسم C",
      status: "occupied",
      capacity: 4,
      studentName: "نورة حسن",
      checkInTime: "09:00",
    },
    {
      id: "C-02",
      name: "C-02",
      section: "القسم C",
      status: "available",
      capacity: 4,
    },
    {
      id: "C-03",
      name: "C-03",
      section: "القسم C",
      status: "reserved",
      capacity: 4,
      reservedUntil: "15:30",
    },
  ]);

  const handleBack = () => {
    navigate(-1);
  };

  const getStatusConfig = (status: TableStatus) => {
    const configs = {
      available: {
        label: "متاحة",
        color: "bg-[#10B981]",
        textColor: "text-[#10B981]",
        bgColor: "bg-[#10B981]/10",
        icon: CheckCircle2,
      },
      occupied: {
        label: "مشغولة",
        color: "bg-[#ffbf1f]",
        textColor: "text-[#ffbf1f]",
        bgColor: "bg-[#ffbf1f]/10",
        icon: User,
      },
      reserved: {
        label: "محجوزة",
        color: "bg-[#034363]",
        textColor: "text-[#034363]",
        bgColor: "bg-[#034363]/10",
        icon: Clock,
      },
      maintenance: {
        label: "صيانة",
        color: "bg-[#EF4444]",
        textColor: "text-[#EF4444]",
        bgColor: "bg-[#EF4444]/10",
        icon: XCircle,
      },
    };
    return configs[status];
  };

  const filteredTables = tables.filter((table) => {
    const matchesSearch =
      table.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      table.section.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesFilter =
      filterStatus === "all" || table.status === filterStatus;
    return matchesSearch && matchesFilter;
  });

  const stats = {
    total: tables.length,
    available: tables.filter((t) => t.status === "available").length,
    occupied: tables.filter((t) => t.status === "occupied").length,
    reserved: tables.filter((t) => t.status === "reserved").length,
    maintenance: tables.filter((t) => t.status === "maintenance").length,
  };

  const handleStatusChange = (table: TableData, newStatus: TableStatus) => {
    // هنا يمكن إضافة منطق تغيير الحالة
    console.log(`تغيير حالة الطاولة ${table.name} إلى ${newStatus}`);
    setSelectedTable(null);
  };

  return (
    <div className="min-h-screen bg-linear-to-br from-blue-50 to-indigo-50">
      {/* Header */}
      <div className="bg-linear-to-br from-[#034363] to-[#045a85] text-white p-6 shadow-lg">
        <div className="max-w-7xl mx-auto">
          <div className="flex items-center gap-4 mb-6">
            <button
              onClick={handleBack}
              className="p-2 hover:bg-white/10 rounded-xl transition-colors"
            >
              <ArrowRight className="w-6 h-6" />
            </button>
            <div>
              <h1 className="text-3xl mb-1">إدارة الطاولات</h1>
              <p className="text-blue-100">عرض وتحديث حالة الطاولات</p>
            </div>
          </div>

          {/* Stats */}
          <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
            <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4">
              <p className="text-sm text-blue-100 mb-1">إجمالي الطاولات</p>
              <p className="text-2xl font-bold">{stats.total}</p>
            </div>
            <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4">
              <p className="text-sm text-blue-100 mb-1">متاحة</p>
              <p className="text-2xl font-bold text-[#10B981]">
                {stats.available}
              </p>
            </div>
            <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4">
              <p className="text-sm text-blue-100 mb-1">مشغولة</p>
              <p className="text-2xl font-bold text-[#ffbf1f]">
                {stats.occupied}
              </p>
            </div>
            <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4">
              <p className="text-sm text-blue-100 mb-1">محجوزة</p>
              <p className="text-2xl font-bold">{stats.reserved}</p>
            </div>
            <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4">
              <p className="text-sm text-blue-100 mb-1">صيانة</p>
              <p className="text-2xl font-bold text-[#EF4444]">
                {stats.maintenance}
              </p>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto p-6">
        {/* Search and Filter */}
        <div className="bg-white rounded-2xl shadow-lg p-6 mb-6">
          <div className="flex flex-col md:flex-row gap-4">
            <div className="flex-1 relative">
              <Search className="absolute right-4 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
              <input
                type="text"
                placeholder="البحث عن طاولة..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full pr-12 pl-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#ffbf1f] transition-all"
              />
            </div>
            <div className="relative">
              <Filter className="absolute right-4 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
              <select
                value={filterStatus}
                onChange={(e) =>
                  setFilterStatus(e.target.value as TableStatus | "all")
                }
                className="pr-12 pl-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#ffbf1f] appearance-none bg-white min-w-50"
              >
                <option value="all">جميع الحالات</option>
                <option value="available">متاحة</option>
                <option value="occupied">مشغولة</option>
                <option value="reserved">محجوزة</option>
                <option value="maintenance">صيانة</option>
              </select>
            </div>
          </div>
        </div>

        {/* Tables Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
          {filteredTables.map((table, index) => {
            const config = getStatusConfig(table.status);
            const Icon = config.icon;

            return (
              <motion.div
                key={table.id}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.05 }}
                onClick={() => setSelectedTable(table)}
                className="cursor-pointer group"
              >
                <div
                  className={`bg-white rounded-2xl p-6 shadow-md hover:shadow-xl transition-all duration-300 border-2 ${
                    selectedTable?.id === table.id
                      ? "border-[#ffbf1f]"
                      : "border-transparent"
                  }`}
                >
                  <div className="flex items-center justify-between mb-4">
                    <div className="flex items-center gap-3">
                      <div
                        className={`w-12 h-12 ${config.bgColor} rounded-xl flex items-center justify-center`}
                      >
                        <Table className={`w-6 h-6 ${config.textColor}`} />
                      </div>
                      <div>
                        <h3 className="text-lg font-bold text-gray-900">
                          {table.name}
                        </h3>
                        <p className="text-sm text-gray-600">{table.section}</p>
                      </div>
                    </div>
                  </div>

                  <div
                    className={`inline-flex items-center gap-2 px-3 py-1.5 ${config.bgColor} rounded-lg mb-4`}
                  >
                    <Icon className={`w-4 h-4 ${config.textColor}`} />
                    <span className={`text-sm font-medium ${config.textColor}`}>
                      {config.label}
                    </span>
                  </div>

                  {table.studentName && (
                    <div className="space-y-2 pt-4 border-t border-gray-100">
                      <div className="flex items-center gap-2 text-sm">
                        <User className="w-4 h-4 text-gray-400" />
                        <span className="text-gray-700">
                          {table.studentName}
                        </span>
                      </div>
                      {table.checkInTime && (
                        <div className="flex items-center gap-2 text-sm">
                          <Clock className="w-4 h-4 text-gray-400" />
                          <span className="text-gray-600">
                            دخول: {table.checkInTime}
                          </span>
                        </div>
                      )}
                    </div>
                  )}

                  {table.reservedUntil && (
                    <div className="pt-4 border-t border-gray-100">
                      <div className="flex items-center gap-2 text-sm">
                        <Clock className="w-4 h-4 text-gray-400" />
                        <span className="text-gray-600">
                          محجوزة حتى: {table.reservedUntil}
                        </span>
                      </div>
                    </div>
                  )}

                  <div className="mt-4 pt-4 border-t border-gray-100">
                    <div className="flex items-center justify-between text-sm">
                      <span className="text-gray-600">السعة:</span>
                      <span className="font-medium text-gray-900">
                        {table.capacity} شخص
                      </span>
                    </div>
                  </div>
                </div>
              </motion.div>
            );
          })}
        </div>

        {filteredTables.length === 0 && (
          <div className="text-center py-12">
            <AlertCircle className="w-16 h-16 text-gray-300 mx-auto mb-4" />
            <p className="text-gray-500">لا توجد طاولات تطابق البحث</p>
          </div>
        )}
      </div>

      {/* Table Details Modal */}
      {selectedTable && (
        <div
          className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4"
          onClick={() => setSelectedTable(null)}
        >
          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            onClick={(e) => e.stopPropagation()}
            className="bg-white rounded-2xl shadow-2xl max-w-md w-full p-6"
          >
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-2xl font-bold text-gray-900">
                تفاصيل الطاولة
              </h2>
              <button
                onClick={() => setSelectedTable(null)}
                className="p-2 hover:bg-gray-100 rounded-xl transition-colors"
              >
                <XCircle className="w-6 h-6 text-gray-500" />
              </button>
            </div>

            <div className="space-y-4 mb-6">
              <div className="flex items-center gap-3 p-4 bg-gray-50 rounded-xl">
                <Table className="w-6 h-6 text-[#034363]" />
                <div>
                  <p className="text-sm text-gray-600">رقم الطاولة</p>
                  <p className="text-lg font-bold text-gray-900">
                    {selectedTable.name}
                  </p>
                </div>
              </div>

              {selectedTable.studentName && (
                <div className="flex items-center gap-3 p-4 bg-gray-50 rounded-xl">
                  <User className="w-6 h-6 text-[#ffbf1f]" />
                  <div>
                    <p className="text-sm text-gray-600">الطالب الحالي</p>
                    <p className="text-lg font-bold text-gray-900">
                      {selectedTable.studentName}
                    </p>
                  </div>
                </div>
              )}

              {selectedTable.checkInTime && (
                <div className="flex items-center gap-3 p-4 bg-gray-50 rounded-xl">
                  <Clock className="w-6 h-6 text-[#10B981]" />
                  <div>
                    <p className="text-sm text-gray-600">وقت تسجيل الدخول</p>
                    <p className="text-lg font-bold text-gray-900">
                      {selectedTable.checkInTime}
                    </p>
                  </div>
                </div>
              )}
            </div>

            <div className="space-y-3">
              <h3 className="font-semibold text-gray-900 mb-3">تغيير الحالة</h3>
              <div className="grid grid-cols-2 gap-3">
                <Button
                  onClick={() => handleStatusChange(selectedTable, "available")}
                  variant={
                    selectedTable.status === "available" ? "primary" : "outline"
                  }
                  className="w-full"
                >
                  <CheckCircle2 className="w-4 h-4 ml-2" />
                  متاحة
                </Button>
                <Button
                  onClick={() => handleStatusChange(selectedTable, "occupied")}
                  variant={
                    selectedTable.status === "occupied" ? "primary" : "outline"
                  }
                  className="w-full"
                >
                  <User className="w-4 h-4 ml-2" />
                  مشغولة
                </Button>
                <Button
                  onClick={() => handleStatusChange(selectedTable, "reserved")}
                  variant={
                    selectedTable.status === "reserved" ? "primary" : "outline"
                  }
                  className="w-full"
                >
                  <Clock className="w-4 h-4 ml-2" />
                  محجوزة
                </Button>
                <Button
                  onClick={() =>
                    handleStatusChange(selectedTable, "maintenance")
                  }
                  variant={
                    selectedTable.status === "maintenance"
                      ? "danger"
                      : "outline"
                  }
                  className="w-full"
                >
                  <XCircle className="w-4 h-4 ml-2" />
                  صيانة
                </Button>
              </div>
            </div>
          </motion.div>
        </div>
      )}
    </div>
  );
}
