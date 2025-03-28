//
//  SupabaseClient.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/28/25.
//

// SupabaseClient.swift
import Supabase
import Foundation

let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://xotethdxtnmrpvcyaxzh.supabase.co")!, // Supabase URL
    supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhvdGV0aGR4dG5tcnB2Y3lheHpoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIxMzg5NTMsImV4cCI6MjA1NzcxNDk1M30.--RdGNecQpx0kixWa9nHGEmB3cIak4dh5Ge3R_YhWdg" // Supabase Anon Key
)
