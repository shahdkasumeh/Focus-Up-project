import React, { useState, useEffect } from "react";
import { motion } from "motion/react";
import { Button } from "../../../components/Button";
import { Input } from "../../../components/Input";
import { X, Save } from "lucide-react";
// 🔴 تم إزالة: import { roomsApi, Room } from "../../../APIMethod/rooms";
// السبب: تم نقل منطق الاتصال بالخادم إلى المكون الأب (RoomsManagement)
import toast from "react-hot-toast";

export function UpdateRoom({
  room, // ✅ تم الإبقاء على prop room (يأتي من المكون الأب)
  onClose,
  onUpdateRoom, // ✅ تغيير: كان onSuccess وأصبح onUpdateRoom للتوضيح
}: {
  room?: {
    id: number;
    name: string;
    capacity: number;
    type: string;
    status?: string;
    is_active?: number;
    is_occupied?: number;
  };
  onClose: () => void;
  onUpdateRoom: (roomData: { id: number; status: string }) => void; // ✅ تغيير: نوع الدالة الجديدة
}) {
  const [formData, setFormData] = useState({
    id: "",
    status: "",
  });
  const [isLoading, setIsLoading] = useState(false);

  // ✅ تحسين: تعبئة النموذج ببيانات القاعة المراد تعديلها
  useEffect(() => {
    if (room) {
      setFormData({
        id: room.id?.toString() || "",
        // ✅ تحسين: تحويل حالة القاعة من الصيغة الأصلية إلى الصيغة المطلوبة
        status:
          room.status || (room.is_active === 1 ? "active" : "inactive") || "",
      });
    }
  }, [room]);

  // ✅ تغيير: كانت handleUpdateRoom والآن handleSubmit
  // ✅ تبسيط: إزالة منطق الاتصال بالـ API والاكتفاء بالتحقق من البيانات وتجميعها
  const handleSubmit = async () => {
    // التحقق من صحة المدخلات
    if (!formData.id || formData.id === "0") {
      toast.error("رقم القاعة مطلوب");
      return;
    }

    if (!formData.status) {
      toast.error("يرجى اختيار حالة القاعة");
      return;
    }

    setIsLoading(true);

    try {
      // ✅ تغيير: تجميع البيانات فقط واستدعاء الدالة من المكون الأب
      const updateData = {
        id: Number(formData.id),
        status: formData.status,
      };

      // استدعاء الدالة من المكون الأب (RoomsManagement)
      // المكون الأب هو المسؤول عن الاتصال بالخادم وتحديث الـ state
      await onUpdateRoom(updateData);

      // إغلاق المودال بعد النجاح
      onClose();
    } catch (error) {
      // ✅ تحسين: رسالة خطأ أفضل مع معالجة不同类型的 الأخطاء
      console.error("فشل في تجهيز بيانات التعديل:", error);
      toast.error(
        error instanceof Error ? error.message : "فشلت عملية تعديل القاعة",
      );
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4"
      onClick={onClose}
    >
      <motion.div
        initial={{ scale: 0.95, opacity: 0, y: 20 }}
        animate={{ scale: 1, opacity: 1, y: 0 }}
        exit={{ scale: 0.95, opacity: 0, y: 20 }}
        onClick={(e) => e.stopPropagation()}
        className="bg-white rounded-3xl shadow-2xl max-w-md w-full overflow-hidden"
      >
        {/* Header */}
        <div className="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex items-center justify-between">
          <h2 className="text-2xl text-gray-900">تعديل القاعة</h2>
          <button
            onClick={onClose}
            className="w-10 h-10 rounded-xl hover:bg-gray-100 flex items-center justify-center transition-colors"
            disabled={isLoading} // ✅ إضافة: تعطيل الزر أثناء التحميل
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Form */}
        <div className="p-6 space-y-5">
          <div className="space-y-1">
            <label className="block text-sm font-semibold text-gray-700">
              رقم القاعة
            </label>
            <Input
              type="number"
              placeholder="مثال: 15"
              value={formData.id}
              onChange={(e) => setFormData({ ...formData, id: e.target.value })}
              className="w-full text-lg font-medium text-center"
              disabled={isLoading}
              min="1"
            />
            {/* ✅ إضافة: نص توضيحي صغير */}
            <p className="text-xs text-gray-500 mt-1">
              أدخل رقم القاعة المراد تعديل حالتها
            </p>
          </div>

          <div className="space-y-1">
            <label className="block text-sm font-semibold text-gray-700">
              حالة القاعة
            </label>
            <select
              value={formData.status}
              onChange={(e) =>
                setFormData({ ...formData, status: e.target.value })
              }
              className="w-full px-4 py-2.5 rounded-xl border border-gray-200 bg-gray-50 focus:bg-white focus:border-blue-400 focus:ring-2 focus:ring-blue-100 transition-all outline-none"
              disabled={isLoading}
            >
              <option value="">اختر الحالة</option>
              <option value="active">نشط</option>
              <option value="inactive">غير نشط</option>
            </select>
            {/* ✅ إضافة: نص توضيحي صغير */}
            <p className="text-xs text-gray-500 mt-1">
              تغيير حالة القاعة سيؤثر على ظهورها للطلاب
            </p>
          </div>
        </div>

        {/* Actions */}
        <div className="flex gap-3 p-6 pt-0">
          <Button
            variant="outline"
            className="flex-1 py-2.5 rounded-xl"
            onClick={onClose}
            disabled={isLoading}
          >
            إلغاء
          </Button>
          <Button
            variant="primary"
            className="flex-1 py-2.5 rounded-xl gap-2"
            onClick={handleSubmit} // ✅ تغيير: كانت handleUpdateRoom والآن handleSubmit
            disabled={isLoading}
          >
            {isLoading ? (
              <>
                <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                جاري التعديل...
              </>
            ) : (
              <>
                <Save className="w-4 h-4" />
                تعديل
              </>
            )}
          </Button>
        </div>
      </motion.div>
    </motion.div>
  );
}
