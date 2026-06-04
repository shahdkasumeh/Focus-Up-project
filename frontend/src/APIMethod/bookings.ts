// src/API Method/bookings.ts
import { api } from "./client";
import { Table } from "./tables";

export interface BookingDetails {
  id_booking: number;
  status: string;
  user: {
    id: number;
    full_name: string;
  };
  place: {
    name: string;
    id: number;
  };
  scheduled_start: string;
  scheduled_end: string;
  actual_start: string | null;
  actual_end: string | null;
  hours: string | null;
  total_price: string | null;
}

export interface BookingCheckInResponse {
  data: {
    id: number;
    status: "active" | "completed" | "cancelled";
    scheduled_start: string | null;
    scheduled_end: string | null;
    actual_start: string;
    actual_end: string | null;
    hours: string | null;
    raw_price: null | string;
    discount_percent: string;
    discount_amount: string;
    total_price: string | null;
    payment_label: null | string;
    action: "check_in" | "check_out";
  };
  message: string;
}

export interface BookingCheckOutResponse {
  data: {
    id: number;
    status: "completed";
    scheduled_start: string | null;
    scheduled_end: string | null;
    actual_start: string;
    actual_end: string;
    hours: string;
    raw_price: string | null;
    discount_percent: string;
    discount_amount: string;
    total_price: string;
    payment_label: string | null;
    action: "check_out";
    table: Table | null;
    room: any | null;
  };
  message: string;
}

export interface BookingRevenues {
  data: {
    bookings: number[];
    revenue: number[];
  };
  message?: string;
}

export const bookingsAPI = {
  checkIn: async (
    bookingId: number | null,
    studentToken: string,
  ): Promise<BookingCheckInResponse> => {
    return api.post<BookingCheckInResponse>(
      `/bookings/check_in`,
      { booking_id: bookingId },
      studentToken, // ← مرره للـ client
    );
  },

  checkOut: async (
    bookingId: number | null,
    studentToken: string, // ← أضف token
  ): Promise<BookingCheckOutResponse> => {
    return api.post<BookingCheckOutResponse>(
      `/bookings/check_out`,
      { booking_id: bookingId },
      studentToken, // ← مرره للـ client
    );
  },

  getBooking: async (bookingId: string) => {
    return api.get(`/bookings/${bookingId}`);
  },

  getBookingDetails: async (): Promise<{ data: BookingDetails[] }> => {
    return api.get<{ data: BookingDetails[] }>(`/bookings/managment`);
  },

  getBookingRevenues: async (): Promise<BookingRevenues> => {
    return api.get<BookingRevenues>(`admin/bookings/last-week`);
  },
};

export default bookingsAPI;
