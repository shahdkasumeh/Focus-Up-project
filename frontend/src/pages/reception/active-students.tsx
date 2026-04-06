import React, { useState } from "react";
import { motion } from "motion/react";
import {
  ArrowRight,
  User,
  Clock,
  MapPin,
  Search,
  LogOut,
  Phone,
  Mail,
} from "lucide-react";
import { Button } from "../../components/Button";

interface ActiveStudentsProps {
  onBack: () => void;
}

interface Student {
  id: string;
  name: string;
  studentId: string;
  table: string;
  checkInTime: string;
  duration: string;
  phone: string;
  email: string;
}

export function ActiveStudents({ onBack }: ActiveStudentsProps) {
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedStudent, setSelectedStudent] = useState<Student | null>(null);

  const [students] = useState<Student[]>([
    {
      id: "1",
      name: "محمد أحمد العتيبي",
      studentId: "STU-2024-001",
      table: "A-12",
      checkInTime: "09:30",
      duration: "2 ساعة و 15 دقيقة",
      phone: "0501234567",
      email: "mohammad@example.com",
    },
    {
      id: "2",
      name: "فاطمة علي الغامدي",
      studentId: "STU-2024-002",
      table: "B-05",
      checkInTime: "08:45",
      duration: "3 ساعات",
      phone: "0507654321",
      email: "fatima@example.com",
    },
    {
      id: "3",
      name: "خالد سعيد القحطاني",
      studentId: "STU-2024-003",
      table: "C-08",
      checkInTime: "10:15",
      duration: "1 ساعة و 30 دقيقة",
      phone: "0509876543",
      email: "khalid@example.com",
    },
    {
      id: "4",
      name: "نورة حسن الدوسري",
      studentId: "STU-2024-004",
      table: "A-15",
      checkInTime: "09:00",
      duration: "2 ساعة و 45 دقيقة",
      phone: "0503456789",
      email: "noura@example.com",
    },
    {
      id: "5",
      name: "عبدالله محمد الشهري",
      studentId: "STU-2024-005",
      table: "B-10",
      checkInTime: "11:00",
      duration: "45 دقيقة",
      phone: "0508765432",
      email: "abdullah@example.com",
    },
  ]);

  const filteredStudents = students.filter(
    (student) =>
      student.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      student.studentId.toLowerCase().includes(searchQuery.toLowerCase()) ||
      student.table.toLowerCase().includes(searchQuery.toLowerCase()),
  );

  const handleCheckOut = (student: Student) => {
    console.log(`تسجيل خروج للطالب: ${student.name}`);
    setSelectedStudent(null);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-50">
      {/* Header */}
      <div className="bg-gradient-to-br from-[#034363] to-[#045a85] text-white p-6 shadow-lg">
        <div className="max-w-7xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <button
              onClick={onBack}
              className="p-2 hover:bg-white/10 rounded-xl transition-colors"
            >
              <ArrowRight className="w-6 h-6" />
            </button>
            <div>
              <h1 className="text-3xl mb-1">الطلاب الحاليين</h1>
              <p className="text-blue-100">عرض الطلاب المتواجدين في المركز</p>
            </div>
          </div>

          <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4 inline-block">
            <p className="text-sm text-blue-100 mb-1">
              إجمالي الطلاب المتواجدين
            </p>
            <p className="text-3xl font-bold">{students.length}</p>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto p-6">
        {/* Search */}
        <div className="bg-white rounded-2xl shadow-lg p-6 mb-6">
          <div className="relative">
            <Search className="absolute right-4 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="البحث بالاسم، رقم الطالب، أو رقم الطاولة..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pr-12 pl-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#ffbf1f] transition-all"
            />
          </div>
        </div>

        {/* Students List */}
        <div className="space-y-4">
          {filteredStudents.map((student, index) => (
            <motion.div
              key={student.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.05 }}
              onClick={() => setSelectedStudent(student)}
              className="bg-white rounded-2xl shadow-md hover:shadow-xl transition-all duration-300 p-6 cursor-pointer group"
            >
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-4 flex-1">
                  <div className="w-14 h-14 bg-gradient-to-br from-[#034363] to-[#045a85] rounded-2xl flex items-center justify-center text-white text-xl font-bold">
                    {student.name.charAt(0)}
                  </div>
                  <div className="flex-1">
                    <h3 className="text-lg font-bold text-gray-900 mb-1">
                      {student.name}
                    </h3>
                    <div className="flex items-center gap-4 text-sm text-gray-600">
                      <span className="flex items-center gap-1">
                        <User className="w-4 h-4" />
                        {student.studentId}
                      </span>
                      <span className="flex items-center gap-1">
                        <MapPin className="w-4 h-4" />
                        طاولة {student.table}
                      </span>
                      <span className="flex items-center gap-1">
                        <Clock className="w-4 h-4" />
                        دخول: {student.checkInTime}
                      </span>
                    </div>
                  </div>
                </div>

                <div className="flex items-center gap-3">
                  <div className="text-left">
                    <p className="text-sm text-gray-600 mb-1">المدة</p>
                    <p className="text-lg font-bold text-[#034363]">
                      {student.duration}
                    </p>
                  </div>
                  <Button
                    onClick={(e) => {
                      e.stopPropagation();
                      handleCheckOut(student);
                    }}
                    variant="outline"
                    size="sm"
                    className="opacity-0 group-hover:opacity-100 transition-opacity"
                  >
                    <LogOut className="w-4 h-4 ml-2" />
                    تسجيل خروج
                  </Button>
                </div>
              </div>
            </motion.div>
          ))}
        </div>

        {filteredStudents.length === 0 && (
          <div className="text-center py-12 bg-white rounded-2xl shadow-lg">
            <User className="w-16 h-16 text-gray-300 mx-auto mb-4" />
            <p className="text-gray-500">لا توجد نتائج للبحث</p>
          </div>
        )}
      </div>

      {/* Student Details Modal */}
      {selectedStudent && (
        <div
          className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4"
          onClick={() => setSelectedStudent(null)}
        >
          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            onClick={(e) => e.stopPropagation()}
            className="bg-white rounded-2xl shadow-2xl max-w-md w-full p-6"
          >
            <h2 className="text-2xl font-bold text-gray-900 mb-6">
              معلومات الطالب
            </h2>

            <div className="space-y-4 mb-6">
              <div className="flex items-center gap-3 p-4 bg-gradient-to-r from-[#034363] to-[#045a85] rounded-xl text-white">
                <div className="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center text-xl font-bold">
                  {selectedStudent.name.charAt(0)}
                </div>
                <div>
                  <p className="text-sm opacity-80">اسم الطالب</p>
                  <p className="text-lg font-bold">{selectedStudent.name}</p>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div className="p-4 bg-gray-50 rounded-xl">
                  <div className="flex items-center gap-2 mb-2">
                    <User className="w-4 h-4 text-gray-400" />
                    <p className="text-sm text-gray-600">رقم الطالب</p>
                  </div>
                  <p className="font-semibold text-gray-900">
                    {selectedStudent.studentId}
                  </p>
                </div>

                <div className="p-4 bg-gray-50 rounded-xl">
                  <div className="flex items-center gap-2 mb-2">
                    <MapPin className="w-4 h-4 text-gray-400" />
                    <p className="text-sm text-gray-600">الطاولة</p>
                  </div>
                  <p className="font-semibold text-gray-900">
                    {selectedStudent.table}
                  </p>
                </div>

                <div className="p-4 bg-gray-50 rounded-xl">
                  <div className="flex items-center gap-2 mb-2">
                    <Clock className="w-4 h-4 text-gray-400" />
                    <p className="text-sm text-gray-600">وقت الدخول</p>
                  </div>
                  <p className="font-semibold text-gray-900">
                    {selectedStudent.checkInTime}
                  </p>
                </div>

                <div className="p-4 bg-gray-50 rounded-xl">
                  <div className="flex items-center gap-2 mb-2">
                    <Clock className="w-4 h-4 text-gray-400" />
                    <p className="text-sm text-gray-600">المدة</p>
                  </div>
                  <p className="font-semibold text-gray-900">
                    {selectedStudent.duration}
                  </p>
                </div>
              </div>

              <div className="p-4 bg-gray-50 rounded-xl">
                <div className="flex items-center gap-2 mb-2">
                  <Phone className="w-4 h-4 text-gray-400" />
                  <p className="text-sm text-gray-600">رقم الجوال</p>
                </div>
                <p className="font-semibold text-gray-900" dir="ltr">
                  {selectedStudent.phone}
                </p>
              </div>

              <div className="p-4 bg-gray-50 rounded-xl">
                <div className="flex items-center gap-2 mb-2">
                  <Mail className="w-4 h-4 text-gray-400" />
                  <p className="text-sm text-gray-600">البريد الإلكتروني</p>
                </div>
                <p className="font-semibold text-gray-900" dir="ltr">
                  {selectedStudent.email}
                </p>
              </div>
            </div>

            <div className="space-y-3">
              <Button
                onClick={() => handleCheckOut(selectedStudent)}
                variant="primary"
                className="w-full"
              >
                <LogOut className="w-5 h-5 ml-2" />
                تسجيل خروج الطالب
              </Button>
              <Button
                onClick={() => setSelectedStudent(null)}
                variant="outline"
                className="w-full"
              >
                إغلاق
              </Button>
            </div>
          </motion.div>
        </div>
      )}
    </div>
  );
}
