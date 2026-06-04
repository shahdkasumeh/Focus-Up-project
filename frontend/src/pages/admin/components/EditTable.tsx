import React, { useState } from "react";
import { motion, AnimatePresence } from "motion/react";
import { X, Save, Hash, Building2 } from "lucide-react";
import { useAuth } from "../../../context/GlobalState";
import { Tables, tablesApi } from "../../../APIMethod/tables";
import toast from "react-hot-toast";

interface EditTableProps {
  table: {
    id: string;
    number: number;
    is_active: number;
    is_occupied: number;
    room_id: number;
  };
  onClose: () => void;
  onSuccess: (updatedTable: Tables) => void;
}

export function EditTable({ table, onClose, onSuccess }: EditTableProps) {
  const { state } = useAuth();
  const [tableNum, setTableNum] = useState<number>(table.number);
  const [roomId, setRoomId] = useState<number>(table.room_id);
  const [loading, setLoading] = useState(false);

  const handleSubmit = async () => {
    if (!tableNum || !roomId) {
      toast.error("يرجى ملء جميع الحقول");
      return;
    }

    setLoading(true);
    try {
      const response = await tablesApi.updateTable({
        id: parseInt(table.id),
        table_num: tableNum,
        room_id: roomId,
      });
      onSuccess(response.data);
    } catch (error) {
      console.error("فشل في تعديل الطاولة:", error);
      toast.error("فشل في تعديل الطاولة");
    } finally {
      setLoading(false);
    }
  };

  return (
    <AnimatePresence>
      {/* Backdrop */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        onClick={onClose}
        className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center"
      >
        {/* Modal */}
        <motion.div
          initial={{ opacity: 0, scale: 0.9, y: 20 }}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          exit={{ opacity: 0, scale: 0.9, y: 20 }}
          transition={{ type: "spring", damping: 20, stiffness: 300 }}
          onClick={(e) => e.stopPropagation()}
          className="bg-white rounded-2xl shadow-2xl w-full max-w-md mx-4 overflow-hidden"
        >
          {/* Header */}
          <div className="bg-linear-to-r from-[#034363] to-[#045a85] p-6 flex items-center justify-between">
            <div>
              <h2 className="text-xl text-white mb-1">تعديل الطاولة</h2>
              <p className="text-white/70 text-sm">
                تعديل بيانات الطاولة رقم {table.number}
              </p>
            </div>
            <button
              onClick={onClose}
              className="w-8 h-8 bg-white/20 hover:bg-white/30 rounded-lg flex items-center justify-center transition-colors"
            >
              <X className="w-4 h-4 text-white" />
            </button>
          </div>

          {/* Body */}
          <div className="p-6 space-y-5" dir="rtl">
            {/* Table Number */}
            <div className="space-y-2">
              <label className="text-sm text-gray-700 flex items-center gap-2">
                <Hash className="w-4 h-4 text-[#034363]" />
                رقم الطاولة
              </label>
              <input
                type="number"
                value={tableNum}
                onChange={(e) => setTableNum(parseInt(e.target.value))}
                min={1}
                className="w-full border border-gray-200 rounded-xl px-4 py-3 text-gray-900 focus:outline-none focus:ring-2 focus:ring-[#034363]/30 focus:border-[#034363] transition-all"
                placeholder="أدخل رقم الطاولة"
              />
            </div>

            {/* Room Selector */}
            <div className="space-y-2">
              <label className="text-sm text-gray-700 flex items-center gap-2">
                <Building2 className="w-4 h-4 text-[#034363]" />
                القاعة
              </label>
              <select
                value={roomId}
                onChange={(e) => setRoomId(parseInt(e.target.value))}
                className="w-full border border-gray-200 rounded-xl px-4 py-3 text-gray-900 focus:outline-none focus:ring-2 focus:ring-[#034363]/30 focus:border-[#034363] transition-all bg-white"
              >
                <option value="">اختر القاعة</option>
                {state.rooms.map((room) => (
                  <option key={room.id} value={room.id}>
                    {room.name}
                  </option>
                ))}
              </select>
            </div>

            {/* Actions */}
            <div className="flex gap-3 pt-2">
              <button
                onClick={handleSubmit}
                disabled={loading}
                className="flex-1 bg-linear-to-r from-[#034363] to-[#045a85] text-white rounded-xl py-3 flex items-center justify-center gap-2 hover:opacity-90 transition-all disabled:opacity-60 disabled:cursor-not-allowed"
              >
                {loading ? (
                  <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                ) : (
                  <>
                    <Save className="w-4 h-4" />
                    حفظ التعديلات
                  </>
                )}
              </button>
              <button
                onClick={onClose}
                className="px-5 border border-gray-200 text-gray-600 rounded-xl hover:bg-gray-50 transition-all"
              >
                إلغاء
              </button>
            </div>
          </div>
        </motion.div>
      </motion.div>
    </AnimatePresence>
  );
}
