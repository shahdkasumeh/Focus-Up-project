import React, { useState, useEffect } from "react";
import { motion } from "motion/react";
import { Button } from "../../../components/Button";
import { Input } from "../../../components/Input";
import { Save, X } from "lucide-react";
import toast from "react-hot-toast";
import { UpdatePrizeData } from "../../../APIMethod/prizes";

interface UpdatePrizeModalProps {
  prize: UpdatePrizeData & { id: number };
  onClose: () => void;
  onUpdatePrize: (prizeData: UpdatePrizeData, prizeId: number) => void;
}

export function UpdatePrizeModal({
  prize,
  onClose,
  onUpdatePrize,
}: UpdatePrizeModalProps) {
  const [formData, setFormData] = useState({
    name: "",
    value: "",
    probability: 10,
  });
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    if (prize) {
      setFormData({
        name: prize.name || "",
        value: prize.value?.toString() || "",
        probability: prize.probability || 10,
      });
    }
  }, [prize]);

  const validateForm = () => {
    if (!formData.name.trim()) {
      toast.error("الرجاء إدخال اسم الجائزة");
      return false;
    }
    if (!formData.value.trim()) {
      toast.error("الرجاء إدخال قيمة الجائزة");
      return false;
    }
    if (!formData.probability || formData.probability <= 0) {
      toast.error("الرجاء إدخال احتمال صحيح (أكبر من 0)");
      return false;
    }
    if (formData.probability > 100) {
      toast.error("الاحتمال لا يمكن أن يتجاوز 100%");
      return false;
    }

    return true;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!validateForm()) return;

    setIsLoading(true);

    const updateData: UpdatePrizeData = {
      name: formData.name.trim(),
      value: formData.value.trim(),
      probability: Number(formData.probability),
    };


    try {
      await onUpdatePrize(updateData, prize.id);
      onClose();
    } catch (error) {
      console.error("Error in update submit:", error);
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
        <form onSubmit={handleSubmit}>
          <div className="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex items-center justify-between">
            <h2 className="text-2xl font-bold text-gray-900">تعديل الجائزة</h2>
            <button
              type="button"
              onClick={onClose}
              className="w-10 h-10 rounded-xl hover:bg-gray-100 flex items-center justify-center transition-colors"
              disabled={isLoading}
            >
              <X className="w-5 h-5" />
            </button>
          </div>

          <div className="p-6 space-y-4">
            <Input
              label="اسم الجائزة"
              placeholder="مثال: discount"
              value={formData.name}
              onChange={(e) =>
                setFormData({ ...formData, name: e.target.value })
              }
              disabled={isLoading}
              required
            />

            <Input
              label="قيمة الجائزة"
              placeholder="مثال: 10 أو good"
              value={formData.value}
              onChange={(e) =>
                setFormData({ ...formData, value: e.target.value })
              }
              disabled={isLoading}
              required
            />

            <Input
              label="نسبة الاحتمال (%)"
              type="number"
              placeholder="من 1 إلى 100"
              value={formData.probability}
              onChange={(e) =>
                setFormData({
                  ...formData,
                  probability: Number(e.target.value),
                })
              }
              disabled={isLoading}
              min={1}
              max={100}
              required
            />
          </div>

          <div className="flex gap-3 p-6 pt-0">
            <Button
              type="button"
              variant="outline"
              className="flex-1"
              onClick={onClose}
              disabled={isLoading}
            >
              إلغاء
            </Button>
            <Button
              type="submit"
              variant="primary"
              className="flex-1 gap-2"
              disabled={isLoading}
            >
              {isLoading ? "جاري التعديل..." : "تعديل"}
            </Button>
          </div>
        </form>
      </motion.div>
    </motion.div>
  );
}
