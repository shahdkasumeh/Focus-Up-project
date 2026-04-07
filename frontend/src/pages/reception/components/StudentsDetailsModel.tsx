import { motion } from "motion/react";
import { User, Clock, MapPin, LogOut, Phone, Mail } from "lucide-react";
import { Button } from "../../../components/Button";

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

interface StudentDetailsProps {
  setSelectedStudent: (student: Student | null) => void;
  selectedStudent: Student | null;
  handleCheckOut: (student: Student) => void;
}

export function StudentsDetailsModel({
  selectedStudent,
  setSelectedStudent,
  handleCheckOut,
}: StudentDetailsProps) {
  if (!selectedStudent) {
    return null;
  }
  return (
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
          <div className="flex items-center gap-3 p-4 bg-linear-to-r from-[#034363] to-[#045a85] rounded-xl text-white">
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
  );
}
