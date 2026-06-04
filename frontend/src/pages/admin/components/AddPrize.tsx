import React, { useState } from "react";
import { motion } from "motion/react";
import { Button } from "../../../components/Button";
import { Input } from "../../../components/Input";
import { X } from "lucide-react";
import toast from "react-hot-toast";
import { CreatePrizeData } from "../../../APIMethod/prizes";

interface AddPrizeModalProps {
  onClose: () => void;
  onAddPrize: (prizeData: CreatePrizeData) => void;
  totalProbability?: number;
}

export function AddPrizeModal({
  onClose,
  onAddPrize,
  totalProbability = 0,
}: AddPrizeModalProps) {
  const [formData, setFormData] = useState({
    name: "",
    value: "",
    probability: 10,
  });
  const [isLoading, setIsLoading] = useState(false);

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
    if (totalProbability + formData.probability > 100) {
      toast.error(
        `مجموع الاحتمالات سيتجاوز 100% (المتبقي: ${100 - totalProbability}%)`,
      );
      return false;
    }

    return true;
  };

  const handleSubmit = async () => {
    if (!validateForm()) return;

    setIsLoading(true);
    const prizeData: CreatePrizeData = {
      name: formData.name,
      value: formData.value,
      probability: formData.probability,
    };

    try {
      await onAddPrize(prizeData);
      onClose();
    } catch (error) {
      console.error("Error adding prize:", error);
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
        <div className="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex items-center justify-between">
          <h2 className="text-2xl font-bold text-gray-900">
            إضافة جائزة جديدة
          </h2>
          <button
            onClick={onClose}
            className="w-10 h-10 rounded-xl hover:bg-gray-100 flex items-center justify-center transition-colors"
            disabled={isLoading}
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-6 space-y-4">
          <div className="flex flex-col gap-1.5">
            <label className="text-sm font-medium text-gray-700">
              اسم الجائزة
            </label>
            <select
              value={formData.name}
              onChange={(e) =>
                setFormData({ ...formData, name: e.target.value })
              }
              disabled={isLoading}
              className="w-full rounded-xl border border-gray-300 bg-white px-3 py-2 text-sm shadow-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 disabled:cursor-not-allowed disabled:opacity-50"
            >
              <option value="" disabled>
                اختر نوع الجائزة
              </option>
              <option value="discount">Discount</option>
              <option value="Better luck">Better Luck</option>
              <option value="message">Message</option>
            </select>
          </div>
          <Input
            label="قيمة الجائزة"
            placeholder="مثال: خصم 50% أو 1000 ليرة"
            value={formData.value}
            onChange={(e) =>
              setFormData({ ...formData, value: e.target.value })
            }
            disabled={isLoading}
          />
          <Input
            label="نسبة الاحتمال (%)"
            type="number"
            placeholder="من 1 إلى 100"
            value={formData.probability}
            onChange={(e) =>
              setFormData({ ...formData, probability: Number(e.target.value) })
            }
            disabled={isLoading}
            min={1}
            max={100}
          />
        </div>

        <div className="flex gap-3 p-6 pt-0">
          <Button
            variant="outline"
            className="flex-1"
            onClick={onClose}
            disabled={isLoading}
          >
            إلغاء
          </Button>
          <Button
            variant="primary"
            className="flex-1 gap-2"
            onClick={handleSubmit}
            disabled={
              isLoading || totalProbability + formData.probability > 100
            }
          >
            {isLoading ? "جاري الإضافة..." : "إضافة"}
          </Button>
        </div>
      </motion.div>
    </motion.div>
  );
}
