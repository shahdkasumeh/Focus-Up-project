// src/API Method/bookings.ts
import { api } from "./client";
import { Table } from "./tables";

export interface BookingCheckInResponse {
  data: {
    id: number;
    status: "active" | "completed" | "cancelled";
    scheduled_start: string;
    scheduled_end: string;
    actual_start: string;
    actual_end: string | null;
    hours: string | null;
    total_price: string | null;
    discount_percent: string;
    discount_amount: string;
    action: "check_in" | "check_out";
    table: Table;
    room: any;
  };
  message: string;
}

export interface BookingCheckOutResponse {
  data: {
    id: number;
    status: "completed";
    scheduled_start: string;
    scheduled_end: string;
    actual_start: string;
    actual_end: string;
    hours: string;
    total_price: string;
    discount_percent: string;
    discount_amount: string;
    action: "check_out";
    table: Table;
    room: any;
  };
  message: string;
}

export const bookingsAPI = {
  checkIn: async (bookingId: string): Promise<BookingCheckInResponse> => {
    return api.post<BookingCheckInResponse>(`/bookings/check_out`, {
      booking_id: bookingId,
    });
  },

  checkOut: async (bookingId: string): Promise<BookingCheckOutResponse> => {
    return api.post<BookingCheckOutResponse>(`/bookings/check_out`, {
      booking_id: bookingId,
    });
  },

  getBooking: async (bookingId: string) => {
    return api.get(`/bookings/${bookingId}`);
  },
};

export default bookingsAPI;
