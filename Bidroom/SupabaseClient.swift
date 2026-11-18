//
//  SupabaseClient.swift
//  BidRoom
//
//  Created by Zachary Legzdin on 11/17/26.
//

import Foundation
import Supabase

// One shared connection to your Supabase project, used everywhere in the app.
// Paste your own values between the quotes.
// Use the PUBLISHABLE key only. Never put the secret key in the app.
let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://lkmanroyjtugsomeqeli.supabase.co")!,
    supabaseKey: "sb_publishable_UWT3i7ysufSb1Zk4ATZJrA_Q79l2V_f"
)
