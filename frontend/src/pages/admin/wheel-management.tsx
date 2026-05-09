import React, { useState } from "react";
import { motion } from "motion/react";
import {
  Gift,
  Plus,
  Edit2,
  Trash2,
  Save,
  X,
  RotateCw,
  Sparkles,
} from "lucide-react";

interface WheelPrize {
  id: string;
  name: string;
  probability: number;
  color: string;
  icon: string;
}

export function WheelManagement() {
  const [prizes, setPrizes] = useState<WheelPrize[]>([
    { id: "1", name: "خصم 50%", probability: 10, color: "#2563EB", icon: "🎉" },
    { id: "2", name: "خصم 30%", probability: 20, color: "#10B981", icon: "🎁" },
    { id: "3", name: "خصم 20%", probability: 25, color: "#F59E0B", icon: "💝" },
    { id: "4", name: "خصم 10%", probability: 30, color: "#8B5CF6", icon: "🎊" },
    {
      id: "5",
      name: "حاول مرة أخرى",
      probability: 15,
      color: "#EF4444",
      icon: "🔄",
    },
  ]);

  const [editingId, setEditingId] = useState<string | null>(null);
  const [editForm, setEditForm] = useState<Partial<WheelPrize>>({});
  const [showAddModal, setShowAddModal] = useState(false);

  const handleEdit = (prize: WheelPrize) => {
    setEditingId(prize.id);
    setEditForm(prize);
  };

  const handleSave = () => {
    if (editingId && editForm) {
      setPrizes((prevPrizes) =>
        prevPrizes.map((p) => (p.id === editingId ? { ...p, ...editForm } : p)),
      );
      setEditingId(null);
      setEditForm({});
    }
  };

  const handleDelete = (id: string) => {
    if (confirm("هل أنت متأكد من حذف هذه الجائزة؟")) {
      setPrizes((prevPrizes) => prevPrizes.filter((p) => p.id !== id));
    }
  };

  const handleAddPrize = (e: React.FormEvent) => {
    e.preventDefault();
    const formData = new FormData(e.target as HTMLFormElement);
    const newPrize: WheelPrize = {
      id: Date.now().toString(),
      name: formData.get("name") as string,
      probability: Number(formData.get("probability")),
      color: formData.get("color") as string,
      icon: formData.get("icon") as string,
    };
    setPrizes([...prizes, newPrize]);
    setShowAddModal(false);
  };

  const totalProbability = prizes.reduce((sum, p) => sum + p.probability, 0);

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl text-gray-900 mb-2">إدارة عجلة الحظ</h1>
          <p className="text-gray-600">تعديل الجوائز والاحتماليات</p>
        </div>
        <button
          onClick={() => setShowAddModal(true)}
          className="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-[#ffbf1f] to-[#e6ac1c] text-[#034363] rounded-xl hover:shadow-lg transition-all"
        >
          <Plus className="w-5 h-5" />
          إضافة جائزة
        </button>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center">
              <Gift className="w-6 h-6 text-purple-600" />
            </div>
            <Sparkles className="w-5 h-5 text-[#ffbf1f]" />
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">{prizes.length}</h3>
          <p className="text-gray-600 text-sm">إجمالي الجوائز</p>
        </div>

        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
              <RotateCw className="w-6 h-6 text-blue-600" />
            </div>
            <Sparkles className="w-5 h-5 text-[#ffbf1f]" />
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">{totalProbability}%</h3>
          <p className="text-gray-600 text-sm">إجمالي الاحتماليات</p>
        </div>

        <div
          className={`rounded-2xl shadow-md p-6 ${
            totalProbability === 100 ? "bg-green-50" : "bg-red-50"
          }`}
        >
          <div className="flex items-center justify-between mb-4">
            <div
              className={`w-12 h-12 rounded-xl flex items-center justify-center ${
                totalProbability === 100 ? "bg-green-100" : "bg-red-100"
              }`}
            >
              <Sparkles
                className={`w-6 h-6 ${
                  totalProbability === 100 ? "text-green-600" : "text-red-600"
                }`}
              />
            </div>
          </div>
          <h3
            className={`text-2xl mb-1 ${
              totalProbability === 100 ? "text-green-700" : "text-red-700"
            }`}
          >
            {totalProbability === 100 ? "متوازن" : "غير متوازن"}
          </h3>
          <p
            className={`text-sm ${
              totalProbability === 100 ? "text-green-600" : "text-red-600"
            }`}
          >
            {totalProbability === 100
              ? "الاحتماليات صحيحة"
              : `يجب أن يكون المجموع 100%`}
          </p>
        </div>
      </div>

      {/* Prizes List */}
      <div className="bg-white rounded-2xl shadow-md overflow-hidden">
        <div className="p-6 border-b border-gray-200">
          <h2 className="text-xl text-gray-900">قائمة الجوائز</h2>
        </div>

        <div className="p-6 space-y-4">
          {prizes.map((prize, index) => (
            <motion.div
              key={prize.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              className="bg-gray-50 rounded-xl p-5 border-2 border-gray-200 hover:border-[#ffbf1f] transition-all"
            >
              {editingId === prize.id ? (
                <div className="space-y-4">
                  <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div>
                      <label className="block text-sm text-gray-700 mb-2">
                        اسم الجائزة
                      </label>
                      <input
                        type="text"
                        value={editForm.name || ""}
                        onChange={(e) =>
                          setEditForm({ ...editForm, name: e.target.value })
                        }
                        className="w-full px-3 py-2 rounded-lg border border-gray-300 focus:border-[#ffbf1f] focus:outline-none"
                      />
                    </div>
                    <div>
                      <label className="block text-sm text-gray-700 mb-2">
                        الاحتمالية (%)
                      </label>
                      <input
                        type="number"
                        value={editForm.probability || 0}
                        onChange={(e) =>
                          setEditForm({
                            ...editForm,
                            probability: Number(e.target.value),
                          })
                        }
                        className="w-full px-3 py-2 rounded-lg border border-gray-300 focus:border-[#ffbf1f] focus:outline-none"
                      />
                    </div>
                    <div>
                      <label className="block text-sm text-gray-700 mb-2">
                        اللون
                      </label>
                      <input
                        type="color"
                        value={editForm.color || "#000000"}
                        onChange={(e) =>
                          setEditForm({ ...editForm, color: e.target.value })
                        }
                        className="w-full h-10 px-1 py-1 rounded-lg border border-gray-300 focus:border-[#ffbf1f] focus:outline-none"
                      />
                    </div>
                    <div>
                      <label className="block text-sm text-gray-700 mb-2">
                        الرمز
                      </label>
                      <input
                        type="text"
                        value={editForm.icon || ""}
                        onChange={(e) =>
                          setEditForm({ ...editForm, icon: e.target.value })
                        }
                        className="w-full px-3 py-2 rounded-lg border border-gray-300 focus:border-[#ffbf1f] focus:outline-none text-2xl text-center"
                      />
                    </div>
                  </div>
                  <div className="flex gap-3">
                    <button
                      onClick={handleSave}
                      className="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition-colors"
                    >
                      <Save className="w-4 h-4" />
                      حفظ
                    </button>
                    <button
                      onClick={() => {
                        setEditingId(null);
                        setEditForm({});
                      }}
                      className="flex items-center gap-2 px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition-colors"
                    >
                      <X className="w-4 h-4" />
                      إلغاء
                    </button>
                  </div>
                </div>
              ) : (
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-4">
                    <div
                      className="w-16 h-16 rounded-xl flex items-center justify-center text-2xl shadow-md"
                      style={{ backgroundColor: prize.color }}
                    >
                      {prize.icon}
                    </div>
                    <div>
                      <h3 className="text-lg text-gray-900 mb-1">
                        {prize.name}
                      </h3>
                      <div className="flex items-center gap-4">
                        <span className="text-sm text-gray-600">
                          الاحتمالية:{" "}
                          <span className="font-bold text-[#034363]">
                            {prize.probability}%
                          </span>
                        </span>
                        <span className="text-sm text-gray-600">
                          اللون:{" "}
                          <span
                            className="inline-block w-6 h-6 rounded-full border-2 border-white shadow-sm"
                            style={{ backgroundColor: prize.color }}
                          ></span>
                        </span>
                      </div>
                    </div>
                  </div>
                  <div className="flex gap-2">
                    <button
                      onClick={() => handleEdit(prize)}
                      className="p-2 bg-[#034363] text-white rounded-lg hover:bg-[#045a85] transition-colors"
                    >
                      <Edit2 className="w-5 h-5" />
                    </button>
                    <button
                      onClick={() => handleDelete(prize.id)}
                      className="p-2 bg-red-50 text-red-600 rounded-lg hover:bg-red-100 transition-colors"
                    >
                      <Trash2 className="w-5 h-5" />
                    </button>
                  </div>
                </div>
              )}
            </motion.div>
          ))}
        </div>
      </div>

      {/* Add Prize Modal */}
      {showAddModal && (
        <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-6">
          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            className="bg-white rounded-2xl shadow-2xl max-w-2xl w-full p-8"
          >
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-2xl text-gray-900">إضافة جائزة جديدة</h2>
              <button
                onClick={() => setShowAddModal(false)}
                className="w-10 h-10 bg-gray-100 hover:bg-gray-200 rounded-xl flex items-center justify-center transition-colors"
              >
                <X className="w-5 h-5 text-gray-600" />
              </button>
            </div>

            <form onSubmit={handleAddPrize} className="space-y-4">
              <div>
                <label className="block text-sm text-gray-700 mb-2">
                  اسم الجائزة
                </label>
                <input
                  type="text"
                  name="name"
                  required
                  className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none"
                  placeholder="مثال: خصم 50%"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm text-gray-700 mb-2">
                    الاحتمالية (%)
                  </label>
                  <input
                    type="number"
                    name="probability"
                    required
                    min="0"
                    max="100"
                    className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none"
                    placeholder="10"
                  />
                </div>
                <div>
                  <label className="block text-sm text-gray-700 mb-2">
                    اللون
                  </label>
                  <input
                    type="color"
                    name="color"
                    required
                    defaultValue="#2563EB"
                    className="w-full h-12 px-2 py-1 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none"
                  />
                </div>
              </div>

              <div>
                <label className="block text-sm text-gray-700 mb-2">
                  الرمز (emoji)
                </label>
                <input
                  type="text"
                  name="icon"
                  required
                  className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none text-2xl text-center"
                  placeholder="🎉"
                />
              </div>

              <div className="flex gap-3 pt-4">
                <button
                  type="button"
                  onClick={() => setShowAddModal(false)}
                  className="flex-1 px-6 py-3 bg-gray-100 text-gray-700 rounded-xl hover:bg-gray-200 transition-colors"
                >
                  إلغاء
                </button>
                <button
                  type="submit"
                  className="flex-1 px-6 py-3 bg-gradient-to-r from-[#ffbf1f] to-[#e6ac1c] text-[#034363] rounded-xl hover:shadow-lg transition-all"
                >
                  إضافة الجائزة
                </button>
              </div>
            </form>
          </motion.div>
        </div>
      )}
    </div>
  );
}
