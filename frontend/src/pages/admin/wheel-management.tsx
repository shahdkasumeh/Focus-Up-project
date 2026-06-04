import { useEffect, useState } from "react";
import { motion } from "motion/react";
import { Gift, Plus, Edit2, Trash2, RotateCw, Sparkles } from "lucide-react";
import { useAuth } from "../../context/GlobalState";
import { ActionTypes } from "../../context/AppReducer";
import toast from "react-hot-toast";
import {
  prizesApi,
  CreatePrizeData,
  UpdatePrizeData,
} from "../../APIMethod/prizes";
import { AddPrizeModal } from "./components/AddPrize";
import { UpdatePrizeModal } from "./components/UpdatePrize";

export function WheelManagement() {
  const { state, dispatch } = useAuth();
  const { prizes } = state;
  const [searchQuery, setSearchQuery] = useState("");
  const [editingPrize, setEditingPrize] = useState<
    (UpdatePrizeData & { id: number }) | null
  >(null);
  const [showAddModal, setShowAddModal] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchPrizes();
  }, []);

  const fetchPrizes = async () => {
    setLoading(true);
    try {
      const response = await prizesApi.getPrizes();
      console.log(response);
      const prizesArray = Array.isArray(response) ? response : [];
      dispatch({ type: ActionTypes.SET_PRIZES, payload: prizesArray });
    } catch (error) {
      console.error("Failed To Retrieve The Prizes", error);
      toast.error("فشل في تحميل الجوائز");
    } finally {
      setLoading(false);
    }
  };

  const handleAddPrize = async (prizeData: CreatePrizeData) => {
    const loadingToast = toast.loading("جاري إضافة الجائزة...");
    try {
      const result = await prizesApi.addPrizes(prizeData);
      dispatch({ type: ActionTypes.ADD_PRIZE, payload: result.data });
      toast.success("تم إضافة الجائزة بنجاح", { id: loadingToast });
      await fetchPrizes();
    } catch (error: any) {
      console.error("Add Failed", error);
      toast.error(error.response?.data?.message || "فشل في إضافة الجائزة", {
        id: loadingToast,
      });
      throw error;
    }
  };

  const handleUpdatePrize = async (
    prizeData: UpdatePrizeData,
    prizeId: number,
  ) => {
    const loadingToast = toast.loading("جاري تعديل الجائزة...");
    try {
      await prizesApi.updatePrizes(prizeId, prizeData);
      dispatch({
        type: ActionTypes.UPDATE_PRIZE,
        payload: { ...prizeData, id: prizeId },
      });
      toast.success("تم تعديل الجائزة بنجاح", { id: loadingToast });
      await fetchPrizes();
    } catch (error: any) {
      console.error("Modify Failed", error);
      toast.error(error.response?.data?.message || "فشل في تعديل الجائزة", {
        id: loadingToast,
      });
      throw error;
    }
  };

  const handleDeletePrize = async (prizeId: number) => {
    const loadingToast = toast.loading("جاري حذف الجائزة...");
    try {
      await prizesApi.deletePrizes(prizeId);
      dispatch({ type: ActionTypes.DELETE_PRIZE, payload: prizeId });
      toast.success("تم حذف الجائزة بنجاح", { id: loadingToast });
      await fetchPrizes();
    } catch (error: any) {
      console.error("Delete Failed", error);
      toast.error(error.response?.data?.message || "فشل في حذف الجائزة", {
        id: loadingToast,
      });
    }
  };

  const prizesList = Array.isArray(prizes) ? prizes : [];

  const filteredPrizes = prizesList.filter((prize) =>
    prize.name?.toLowerCase().includes(searchQuery.toLowerCase()),
  );

  const totalProbability = prizesList.reduce(
    (sum, p) => sum + (p.probability || 0),
    0,
  );

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <div className="w-16 h-16 border-4 border-[#ffbf1f] border-t-transparent rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-gray-600">جاري تحميل الجوائز...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 mb-2">
            إدارة عجلة الحظ
          </h1>
          <p className="text-gray-600">تعديل الجوائز والاحتماليات</p>
        </div>
        <button
          onClick={() => setShowAddModal(true)}
          className="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-[#ffbf1f] to-[#e6ac1c] text-[#034363] font-semibold rounded-xl hover:shadow-lg transition-all"
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
          <h3 className="text-2xl font-bold text-gray-900 mb-1">
            {filteredPrizes.length}
          </h3>
          <p className="text-gray-600 text-sm">إجمالي الجوائز</p>
        </div>

        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
              <RotateCw className="w-6 h-6 text-blue-600" />
            </div>
            <Sparkles className="w-5 h-5 text-[#ffbf1f]" />
          </div>
          <h3 className="text-2xl font-bold text-gray-900 mb-1">
            {totalProbability}%
          </h3>
          <p className="text-gray-600 text-sm">إجمالي الاحتماليات</p>
        </div>

        <div
          className={`rounded-2xl shadow-md p-6 ${totalProbability === 100 ? "bg-green-50" : "bg-red-50"}`}
        >
          <div className="flex items-center justify-between mb-4">
            <div
              className={`w-12 h-12 rounded-xl flex items-center justify-center ${totalProbability === 100 ? "bg-green-100" : "bg-red-100"}`}
            >
              <Sparkles
                className={`w-6 h-6 ${totalProbability === 100 ? "text-green-600" : "text-red-600"}`}
              />
            </div>
          </div>
          <h3
            className={`text-2xl font-bold mb-1 ${totalProbability === 100 ? "text-green-700" : "text-red-700"}`}
          >
            {totalProbability === 100 ? "متوازن" : "غير متوازن"}
          </h3>
          <p
            className={`text-sm ${totalProbability === 100 ? "text-green-600" : "text-red-600"}`}
          >
            {totalProbability === 100
              ? "الاحتماليات صحيحة"
              : `يجب أن يكون المجموع 100% (الحالي: ${totalProbability}%)`}
          </p>
        </div>
      </div>

      {/* Search Bar */}
      <div className="bg-white rounded-2xl shadow-md p-6">
        <input
          type="text"
          placeholder="بحث عن جائزة..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none transition-colors"
        />
      </div>

      {/* Prizes List */}
      <div className="bg-white rounded-2xl shadow-md overflow-hidden">
        <div className="p-6 border-b border-gray-200">
          <h2 className="text-xl font-bold text-gray-900">قائمة الجوائز</h2>
        </div>
        <div className="p-6 space-y-4">
          {filteredPrizes.length === 0 ? (
            <div className="text-center py-12">
              <Gift className="w-16 h-16 text-gray-300 mx-auto mb-4" />
              <p className="text-gray-500 text-lg">لا توجد جوائز حالياً</p>
              <button
                onClick={() => setShowAddModal(true)}
                className="mt-4 text-[#ffbf1f] hover:text-[#e6ac1c] font-semibold"
              >
                أضف أول جائزة +
              </button>
            </div>
          ) : (
            filteredPrizes.map((prize, index) => (
              <motion.div
                key={prize.id}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1 }}
                className="bg-gray-50 rounded-xl p-5 border-2 border-gray-200 hover:border-[#ffbf1f] transition-all"
              >
                <div className="flex items-center justify-between">
                  <div className="flex-1">
                    <h3 className="text-lg font-bold text-gray-900 mb-2">
                      {prize.name}
                    </h3>
                    <div className="flex flex-wrap items-center gap-4">
                      <span className="text-sm text-gray-600">
                        القيمة:{" "}
                        <span className="font-bold text-[#034363]">
                          {prize.value}
                        </span>
                      </span>
                      <span className="text-sm text-gray-600">
                        الاحتمالية:{" "}
                        <span className="font-bold text-[#ffbf1f]">
                          {prize.probability || 0}%
                        </span>
                      </span>
                    </div>
                  </div>
                  <div className="flex gap-2">
                    <button
                      onClick={() =>
                        setEditingPrize({
                          id: prize.id,
                          name: prize.name,
                          value: prize.value,
                          probability: prize.probability || 10,
                        })
                      }
                      className="p-2 bg-[#034363] text-white rounded-lg hover:bg-[#045a85] transition-colors"
                    >
                      <Edit2 className="w-5 h-5" />
                    </button>
                    <button
                      onClick={() => handleDeletePrize(prize.id)}
                      className="p-2 bg-red-50 text-red-600 rounded-lg hover:bg-red-100 transition-colors"
                    >
                      <Trash2 className="w-5 h-5" />
                    </button>
                  </div>
                </div>
              </motion.div>
            ))
          )}
        </div>
      </div>

      {/* Modals */}
      {showAddModal && (
        <AddPrizeModal
          onClose={() => setShowAddModal(false)}
          onAddPrize={handleAddPrize}
          totalProbability={totalProbability}
        />
      )}

      {editingPrize && (
        <UpdatePrizeModal
          prize={editingPrize}
          onClose={() => setEditingPrize(null)}
          onUpdatePrize={handleUpdatePrize}
        />
      )}
    </div>
  );
}
