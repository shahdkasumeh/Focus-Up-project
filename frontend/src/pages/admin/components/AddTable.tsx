import React, { useState } from "react";
import { motion } from "motion/react";
import { Button } from "../../../components/Button";
import { Input } from "../../../components/Input";
import { Plus, X } from "lucide-react";
import toast from "react-hot-toast";
import { Table, tablesApi } from "../../../APIMethod/tables";

export function AddTable({
  onClose,
  onSuccess,
}: {
  onClose: () => void;
  onSuccess?: (table: Table) => void;
}) {
  const [formData, setFormData] = useState({
    table_num: 0,
    room_id: 0,
  });

  const handleAddTable = async () => {
    try {
      console.log("tablesApi.addTable:", tablesApi.addTable);
      const result = await tablesApi.addTable({
        table_num: formData.table_num,
        room_id: formData.room_id,
      });
      console.log("تمت الإضافة بنجاح!");

      if (onSuccess) {
        onSuccess(result.data);
      }

      onClose();
    } catch (error) {
      console.error("فشل الإضافة:", error);
      toast.error("Add Failed ");
    }
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
          <div className="grid grid-cols-2 gap-6">
            <div className="space-y-2">
              <label className="block text-sm font-medium text-gray-700">
                رقم الطاولة{" "}
              </label>
              <Input
                type="number"
                placeholder="15"
                value={formData.table_num}
                onChange={(e) =>
                  setFormData({
                    ...formData,
                    table_num: parseInt(e.target.value, 10),
                  })
                }
                className="w-full"
              />
            </div>

            <div className="space-y-2">
              <label className="block text-sm font-medium text-gray-700">
                رقم القاعة{" "}
              </label>
              <Input
                type="number"
                placeholder="15"
                value={formData.room_id}
                onChange={(e) =>
                  setFormData({
                    ...formData,
                    room_id: parseInt(e.target.value, 10),
                  })
                }
                className="w-full"
              />
            </div>
          </div>

          <div className="flex gap-3 pt-4">
            <Button variant="outline" className="flex-1" onClick={onClose}>
              إلغاء
            </Button>
            <Button
              variant="primary"
              className="flex-1"
              onClick={handleAddTable}
            >
              <Plus className="w-5 h-5 ml-2" />
              إضافة القاعة
            </Button>
          </div>
        </div>
      </motion.div>
    </motion.div>
  );
}
