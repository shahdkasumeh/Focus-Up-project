import React, { useEffect, useState } from "react";
import { motion } from "motion/react";
import { ArrowRight, User, Clock, MapPin, Search } from "lucide-react";
import { useNavigate } from "react-router-dom";
import { StudentsDetailsModel } from "./components/StudentsDetailsModel";
import { useAuth } from "../../context/GlobalState";
import { ActionTypes } from "../../context/AppReducer";
import { BookingDetails, bookingsAPI } from "../../APIMethod/bookings";
import toast from "react-hot-toast";

export function ActiveStudents() {
  const navigate = useNavigate();
  const { state, dispatch } = useAuth();
  const { bookingDetails } = state;
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedStudent, setSelectedStudent] = useState<BookingDetails | null>(
    null,
  );
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchBookingDetails();
  }, []);

  const fetchBookingDetails = async () => {
    setLoading(true);
    try {
      const response = await bookingsAPI.getBookingDetails();
      console.log("الحجوزات المستلمة:", response.data);
      dispatch({
        type: ActionTypes.SET_BOOKINGDETAILS,
        payload: response.data,
      });
    } catch (error) {
      console.error("فشل في جلب الحجوزات:", error);
      toast.error("فشل في تحميل الحجوزات");
    } finally {
      setLoading(false);
    }
  };

  const filteredBookings = bookingDetails.filter(
    (booking) =>
      booking.user.full_name
        .toLowerCase()
        .includes(searchQuery.toLowerCase()) ||
      booking.user.id.toString().includes(searchQuery.toLowerCase()) ||
      booking.place.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      booking.status.toLowerCase().includes(searchQuery.toLowerCase()),
  );

  const handleBack = () => {
    navigate(-1);
  };

  return (
    <div className="min-h-screen bg-linear-to-br from-blue-50 to-indigo-50">
      {/* Header */}
      <div className="bg-linear-to-br from-[#034363] to-[#045a85] text-white p-6 shadow-lg">
        <div className="max-w-7xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <button
              onClick={handleBack}
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
            <p className="text-3xl font-bold">{bookingDetails.length}</p>
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
          {filteredBookings.map((student, index) => (
            <motion.div
              key={index}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.05 }}
              onClick={() => setSelectedStudent(student)}
              className="bg-white rounded-2xl shadow-md hover:shadow-xl transition-all duration-300 p-6 cursor-pointer group"
            >
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-4 flex-1">
                  <div className="w-14 h-14 bg-linear-to-br from-[#034363] to-[#045a85] rounded-2xl flex items-center justify-center text-white text-xl font-bold">
                    {student.user.full_name.charAt(0)}
                  </div>
                  <div className="flex-1">
                    <h3 className="text-lg font-bold text-gray-900 mb-1">
                      {student.user.full_name}
                    </h3>
                    <div className="flex items-center gap-4 text-sm text-gray-600">
                      <span className="flex items-center gap-1">
                        <User className="w-4 h-4" />
                        {student.user.id}
                      </span>
                      <span className="flex items-center gap-1">
                        <MapPin className="w-4 h-4" />
                        طاولة {student.place.name}
                      </span>
                      <span className="flex items-center gap-1">
                        <Clock className="w-4 h-4" />
                        دخول: {student.actual_start}
                      </span>
                    </div>
                  </div>
                </div>

                <div className="flex items-center gap-3">
                  <div className="text-left">
                    <p className="text-sm text-gray-600 mb-1">المدة</p>
                    <p className="text-lg font-bold text-[#034363]">
                      {student.hours}
                    </p>
                  </div>
                </div>
              </div>
            </motion.div>
          ))}
        </div>

        {filteredBookings.length === 0 && (
          <div className="text-center py-12 bg-white rounded-2xl shadow-lg">
            <User className="w-16 h-16 text-gray-300 mx-auto mb-4" />
            <p className="text-gray-500">لا توجد نتائج للبحث</p>
          </div>
        )}
      </div>

      {/* Student Details Modal */}
      {selectedStudent && (
        <StudentsDetailsModel
          setSelectedStudent={setSelectedStudent}
          selectedStudent={selectedStudent}
        />
      )}
    </div>
  );
}
