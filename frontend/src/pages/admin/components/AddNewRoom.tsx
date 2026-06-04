import React, { useState } from "react";
import { motion } from "motion/react";
import { Button } from "../../../components/Button";
import { Input } from "../../../components/Input";
import { Plus, X } from "lucide-react";
import toast from "react-hot-toast";
import { CreateRoomData } from "../../../APIMethod/rooms";

export function AddNewRoom({
  onClose,
  onAddRoom,
}: {
  onClose: () => void;
  onAddRoom: (roomData: CreateRoomData) => void;
}) {
  const [formData, setFormData] = useState({
    name: "",
    capacity: "",
    type: "",
  });

  const handleSubmit = () => {
    if (!formData.name.trim()) {
      toast.error("يرجى إدخال اسم القاعة");
      return;
    }
    if (!formData.capacity || Number(formData.capacity) <= 0) {
      toast.error("يرجى إدخال سعة صحيحة (أكبر من 0)");
      return;
    }
    if (!formData.type.trim()) {
      toast.error("يرجى إدخال نوع القاعة");
      return;
    }

    const roomData = {
      name: formData.name,
      capacity: Number(formData.capacity),
      type: formData.type,
    };

    onAddRoom(roomData);
  };

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-6"
      onClick={onClose}
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
            onClick={onClose}
            className="w-10 h-10 rounded-xl hover:bg-gray-100 flex items-center justify-center transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-6 space-y-5">
          <Input
            label="اسم القاعة"
            placeholder="مثال: قاعة النجاح"
            value={formData.name}
            onChange={(e) => setFormData({ ...formData, name: e.target.value })}
          />

          <div className="grid grid-cols-2 gap-6">
            <div className="space-y-2">
              <div className="flex flex-col gap-1.5">
                <label className="text-sm font-medium text-gray-700">
                  حالة القاعة
                </label>
                <select
                  value={formData.type}
                  onChange={(e) =>
                    setFormData({ ...formData, type: e.target.value })
                  }
                  className="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-sm shadow-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 disabled:cursor-not-allowed disabled:opacity-50"
                >
                  <option value="" disabled>
                    اختر حالة القاعة
                  </option>
                  <option value="quiet">Quiet</option>
                  <option value="social_smoking">Social Smoking</option>
                  <option value="social_no_smoking">Social No Smoking</option>
                  <option value="discussion">Discussion</option>
                  <option value="social">Social</option>
                </select>
              </div>
            </div>

            <div className="space-y-2">
              <label className="block text-sm font-medium text-gray-700">
                السعة
              </label>
              <Input
                type="number"
                placeholder="15"
                value={formData.capacity}
                onChange={(e) =>
                  setFormData({ ...formData, capacity: e.target.value })
                }
                className="w-full"
              />
            </div>
          </div>

          <div className="flex gap-3 pt-4">
            <Button variant="outline" className="flex-1" onClick={onClose}>
              إلغاء
            </Button>
            <Button variant="primary" className="flex-1" onClick={handleSubmit}>
              <Plus className="w-5 h-5 ml-2" />
              إضافة القاعة
            </Button>
          </div>
        </div>
      </motion.div>
    </motion.div>
  );
}
