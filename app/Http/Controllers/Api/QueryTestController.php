<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;

class QueryTestController extends Controller
{
    /**
     * QUERY 1: Menampilkan daftar pesanan lengkap dengan:
     * - nama pelanggan
     * - nomor telepon
     * - total pesanan
     * - tanggal pesanan
     * Urutkan dari yang terbaru
     */
    public function query1(): JsonResponse
    {
        $results = DB::table('orders as o')
            ->join('customers as c', 'o.customer_id', '=', 'c.customer_id')
            ->select(
                'o.order_id',
                'c.name as nama_pelanggan',
                'c.phone as nomor_telepon',
                'o.order_total as total_pesanan',
                'o.order_date as tanggal_pesanan',
                'o.status'
            )
            ->orderBy('o.order_date', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'query' => 'Query 1: Daftar pesanan lengkap dengan informasi pelanggan (urutkan terbaru)',
            'data' => $results
        ], 200);
    }

    /**
     * QUERY 2: Menampilkan pelanggan yang belum pernah 
     * membuat pesanan sama sekali
     */
    public function query2(): JsonResponse
    {
        $results = DB::table('customers as c')
            ->leftJoin('orders as o', 'c.customer_id', '=', 'o.customer_id')
            ->whereNull('o.order_id')
            ->select(
                'c.customer_id',
                'c.name as nama_pelanggan',
                'c.phone as nomor_telepon',
                'c.email',
                'c.created_at as tanggal_registrasi'
            )
            ->get();

        return response()->json([
            'success' => true,
            'query' => 'Query 2: Pelanggan yang belum pernah membuat pesanan',
            'data' => $results
        ], 200);
    }

    /**
     * QUERY 3: Menampilkan jumlah pesanan per hari 
     * dalam 7 hari terakhir
     */
    public function query3(): JsonResponse
    {
        $results = DB::table('orders')
            ->select(
                DB::raw('DATE(order_date) as tanggal'),
                DB::raw('COUNT(*) as jumlah_pesanan'),
                DB::raw('SUM(order_total) as total_harian'),
                DB::raw('AVG(order_total) as rata_rata_harian')
            )
            ->where('order_date', '>=', DB::raw('DATE_SUB(CURDATE(), INTERVAL 7 DAY)'))
            ->groupBy(DB::raw('DATE(order_date)'))
            ->orderBy('tanggal', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'query' => 'Query 3: Jumlah pesanan per hari dalam 7 hari terakhir',
            'data' => $results
        ], 200);
    }

    /**
     * QUERY 4: Menampilkan order terbesar untuk 
     * setiap pelanggan
     */
    public function query4(): JsonResponse
    {
        $results = DB::table('customers as c')
            ->join('orders as o', 'c.customer_id', '=', 'o.customer_id')
            ->join(DB::raw('(
                SELECT 
                    customer_id,
                    MAX(order_total) AS max_total
                FROM orders
                GROUP BY customer_id
            ) as max_orders'), function($join) {
                $join->on('o.customer_id', '=', 'max_orders.customer_id')
                     ->on('o.order_total', '=', 'max_orders.max_total');
            })
            ->select(
                'c.customer_id',
                'c.name as nama_pelanggan',
                'c.phone as nomor_telepon',
                'o.order_id',
                'o.order_total as total_terbesar',
                'o.order_date as tanggal_pesanan',
                'o.status'
            )
            ->orderBy('o.order_total', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'query' => 'Query 4: Order terbesar untuk setiap pelanggan',
            'data' => $results
        ], 200);
    }

    /**
     * QUERY 5: Menampilkan rata-rata total order harian 
     * dan membandingkannya dengan order hari ini
     */
    public function query5(): JsonResponse
    {
        $results = DB::table('orders as o')
            ->select(
                DB::raw('DATE(o.order_date) as tanggal'),
                DB::raw('COUNT(*) as jumlah_order_hari_ini'),
                DB::raw('SUM(o.order_total) as total_order_hari_ini'),
                DB::raw('AVG(o.order_total) as rata_rata_order_hari_ini'),
                DB::raw('(
                    SELECT AVG(daily_total)
                    FROM (
                        SELECT DATE(order_date) AS tanggal, SUM(order_total) AS daily_total
                        FROM orders
                        WHERE order_date < CURDATE()
                        GROUP BY DATE(order_date)
                    ) AS daily_averages
                ) as rata_rata_total_harian_sebelumnya'),
                DB::raw('(
                    SELECT AVG(order_total)
                    FROM orders
                    WHERE DATE(order_date) < CURDATE()
                ) as rata_rata_order_per_item_sebelumnya')
            )
            ->where(DB::raw('DATE(o.order_date)'), '=', DB::raw('CURDATE()'))
            ->groupBy(DB::raw('DATE(o.order_date)'))
            ->get();

        return response()->json([
            'success' => true,
            'query' => 'Query 5: Rata-rata total order harian dan perbandingan dengan hari ini',
            'data' => $results
        ], 200);
    }

    /**
     * Menampilkan semua query test sekaligus
     */
    public function all(): JsonResponse
    {
        // Query 1
        $query1 = DB::table('orders as o')
            ->join('customers as c', 'o.customer_id', '=', 'c.customer_id')
            ->select(
                'o.order_id',
                'c.name as nama_pelanggan',
                'c.phone as nomor_telepon',
                'o.order_total as total_pesanan',
                'o.order_date as tanggal_pesanan',
                'o.status'
            )
            ->orderBy('o.order_date', 'desc')
            ->get();

        // Query 2
        $query2 = DB::table('customers as c')
            ->leftJoin('orders as o', 'c.customer_id', '=', 'o.customer_id')
            ->whereNull('o.order_id')
            ->select(
                'c.customer_id',
                'c.name as nama_pelanggan',
                'c.phone as nomor_telepon',
                'c.email',
                'c.created_at as tanggal_registrasi'
            )
            ->get();

        // Query 3
        $query3 = DB::table('orders')
            ->select(
                DB::raw('DATE(order_date) as tanggal'),
                DB::raw('COUNT(*) as jumlah_pesanan'),
                DB::raw('SUM(order_total) as total_harian'),
                DB::raw('AVG(order_total) as rata_rata_harian')
            )
            ->where('order_date', '>=', DB::raw('DATE_SUB(CURDATE(), INTERVAL 7 DAY)'))
            ->groupBy(DB::raw('DATE(order_date)'))
            ->orderBy('tanggal', 'desc')
            ->get();

        // Query 4
        $query4 = DB::table('customers as c')
            ->join('orders as o', 'c.customer_id', '=', 'o.customer_id')
            ->join(DB::raw('(
                SELECT 
                    customer_id,
                    MAX(order_total) AS max_total
                FROM orders
                GROUP BY customer_id
            ) as max_orders'), function($join) {
                $join->on('o.customer_id', '=', 'max_orders.customer_id')
                     ->on('o.order_total', '=', 'max_orders.max_total');
            })
            ->select(
                'c.customer_id',
                'c.name as nama_pelanggan',
                'c.phone as nomor_telepon',
                'o.order_id',
                'o.order_total as total_terbesar',
                'o.order_date as tanggal_pesanan',
                'o.status'
            )
            ->orderBy('o.order_total', 'desc')
            ->get();

        // Query 5
        $query5 = DB::table('orders as o')
            ->select(
                DB::raw('DATE(o.order_date) as tanggal'),
                DB::raw('COUNT(*) as jumlah_order_hari_ini'),
                DB::raw('SUM(o.order_total) as total_order_hari_ini'),
                DB::raw('AVG(o.order_total) as rata_rata_order_hari_ini'),
                DB::raw('(
                    SELECT AVG(daily_total)
                    FROM (
                        SELECT DATE(order_date) AS tanggal, SUM(order_total) AS daily_total
                        FROM orders
                        WHERE order_date < CURDATE()
                        GROUP BY DATE(order_date)
                    ) AS daily_averages
                ) as rata_rata_total_harian_sebelumnya'),
                DB::raw('(
                    SELECT AVG(order_total)
                    FROM orders
                    WHERE DATE(order_date) < CURDATE()
                ) as rata_rata_order_per_item_sebelumnya')
            )
            ->where(DB::raw('DATE(o.order_date)'), '=', DB::raw('CURDATE()'))
            ->groupBy(DB::raw('DATE(o.order_date)'))
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'Semua query test',
            'queries' => [
                'query1' => [
                    'description' => 'Query 1: Daftar pesanan lengkap dengan informasi pelanggan (urutkan terbaru)',
                    'data' => $query1
                ],
                'query2' => [
                    'description' => 'Query 2: Pelanggan yang belum pernah membuat pesanan',
                    'data' => $query2
                ],
                'query3' => [
                    'description' => 'Query 3: Jumlah pesanan per hari dalam 7 hari terakhir',
                    'data' => $query3
                ],
                'query4' => [
                    'description' => 'Query 4: Order terbesar untuk setiap pelanggan',
                    'data' => $query4
                ],
                'query5' => [
                    'description' => 'Query 5: Rata-rata total order harian dan perbandingan dengan hari ini',
                    'data' => $query5
                ],
            ]
        ], 200);
    }
}
