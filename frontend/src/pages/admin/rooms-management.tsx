import { useState, useEffect } from "react";
import { motion } from "motion/react";
import { Button } from "../../components/Button";
import { Plus, Search, Edit2, Trash2, MapPin, Users } from "lucide-react";
import { AddNewRoom } from "./components/AddNewRoom";
import { roomsApi, Room } from "../../APIMethod/rooms";
import { useAuth } from "../../context/GlobalState";
import { ActionTypes } from "../../context/AppReducer";
import toast from "react-hot-toast";
import { UpdateRoom } from "./components/UpdateRoom";

export function RoomsManagement() {
  const { state, dispatch } = useAuth();
  const { rooms } = state;
  const [searchQuery, setSearchQuery] = useState("");
  const [showAddRoomModal, setShowAddRoomModal] = useState(false);
  const [loading, setLoading] = useState(true);
  const [filterStatus, setFilterStatus] = useState("all");
  const [EditRoom, setEditRoom] = useState(false);

  useEffect(() => {
    fetchRooms();
  }, []);

  const fetchRooms = async () => {
    setLoading(true);
    try {
      const response = await roomsApi.getRooms();
      console.log("القاعات المستلمة:", response.data);
      dispatch({ type: ActionTypes.SET_ROOMS, payload: response.data });
    } catch (error) {
      console.error("فشل في جلب القاعات:", error);
      toast.error("فشل في تحميل القاعات");
    } finally {
      setLoading(false);
    }
  };

  const handleRoomAdded = (newRoom: Room) => {
    dispatch({ type: ActionTypes.ADD_ROOM, payload: newRoom });
    setShowAddRoomModal(false);
    toast.success("تمت إضافة القاعة بنجاح");
  };

  const handleRoomUpdate = (newRoom: Room) => {
    dispatch({ type: ActionTypes.UPDATE_ROOM, payload: newRoom });
    setShowAddRoomModal(false);
    toast.success("تمت تعديل القاعة بنجاح");
  };

  const handleRoomDelete = async (roomId: number) => {
    try {
      await roomsApi.deleteRoom(roomId);

      dispatch({
        type: ActionTypes.DELETE_ROOM,
        payload: roomId,
      });

      toast.success("تم حذف القاعة بنجاح");
    } catch (error) {
      console.error("فشل في حذف القاعة:", error);
      toast.error("فشل في حذف القاعة");
    }
  };

  const filteredRooms = rooms.filter((room) => {
    const matchesSearch = room.name
      .toLowerCase()
      .includes(searchQuery.toLowerCase());
    const matchesStatus =
      filterStatus === "all" ||
      (filterStatus === "active" &&
        room.is_active === 1 &&
        room.is_occupied === 1) ||
      (filterStatus === "inactive" &&
        room.is_active === 0 &&
        room.is_occupied === 1);
    return matchesSearch && matchesStatus;
  });

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl text-gray-900 mb-2">إدارة القاعات</h1>
          <p className="text-gray-600">إضافة وتعديل وحذف القاعات الدراسية</p>
        </div>
        <Button variant="primary" onClick={() => setShowAddRoomModal(true)}>
          <Plus className="w-5 h-5 ml-2" />
          إضافة قاعة جديدة
        </Button>
      </div>

      {/* Search & Filters */}
      <div className="bg-white rounded-2xl shadow-md p-6">
        <div className="flex gap-4">
          <div className="flex-1 relative">
            <Search className="absolute right-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="ابحث عن قاعة..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pr-11 pl-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#ffbf1f]"
            />
          </div>
          <select
            value={filterStatus}
            onChange={(e) => setFilterStatus(e.target.value)}
            className="px-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#ffbf1f]"
          >
            <option value="all">جميع الحالات</option>
            <option value="active">نشطة</option>
            <option value="inactive">غير نشطة</option>
          </select>
        </div>
      </div>

      {/* Rooms Grid */}
      {loading ? (
        <div className="flex justify-center items-center h-64">
          <div className="text-gray-500">جاري تحميل القاعات...</div>
        </div>
      ) : filteredRooms.length === 0 ? (
        <div className="flex justify-center items-center h-64">
          <div className="text-gray-500">لا توجد قاعات مطابقة للبحث</div>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredRooms.map((room, index) => (
            <motion.div
              key={room.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              className="bg-white rounded-2xl shadow-md overflow-hidden hover:shadow-lg transition-shadow"
            >
              {/* Image */}
              <div className="h-40 bg-linear-to-br from-blue-100 to-indigo-100 relative flex items-center justify-center">
                <MapPin className="w-16 h-16 text-[#2563EB] opacity-30" />
              </div>

              {/* Content */}
              <div className="p-5">
                <div className="flex items-start justify-between mb-3">
                  <div>
                    <h3 className="text-lg text-gray-900 mb-1">{room.name}</h3>
                    <p className="text-sm text-gray-500">{room.type}</p>
                  </div>
                  <div
                    className={`px-2 py-0.5 rounded-full text-xs ${
                      room.is_active === 1 && room.is_occupied === 1
                        ? "bg-[#10B981] text-white"
                        : "bg-gray-400 text-white"
                    }`}
                  >
                    {room.is_active === 1 && room.is_occupied === 1
                      ? "نشط"
                      : "غير نشط"}
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-3 mb-4">
                  <div className="flex items-center gap-2 text-sm text-gray-600">
                    <Users className="w-4 h-4" />
                    {room.capacity} مقعد
                  </div>
                </div>

                <div className="flex gap-2 pt-4 border-t border-gray-100">
                  <Button
                    variant="outline"
                    size="sm"
                    className="flex-1"
                    onClick={() => setEditRoom(true)}
                  >
                    <Edit2 className="w-4 h-4 ml-1" />
                    تعديل
                  </Button>
                  <Button
                    variant="outline"
                    size="sm"
                    className="flex-1 text-red-600 border-red-600 hover:bg-red-500 hover:text-white"
                    onClick={() => handleRoomDelete(room.id)}
                  >
                    <Trash2 className="w-4 h-4 ml-1" />
                    حذف
                  </Button>
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      )}

      {/* Update Room Modal */}
      {EditRoom && (
        <UpdateRoom
          onClose={() => setEditRoom(false)}
          onSuccess={handleRoomUpdate}
        />
      )}
      {/* Add Room Modal */}
      {showAddRoomModal && (
        <AddNewRoom
          onClose={() => setShowAddRoomModal(false)}
          onSuccess={handleRoomAdded}
        />
      )}
    </div>
  );
}
