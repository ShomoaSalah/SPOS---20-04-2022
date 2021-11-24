//
//  APIConstant.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/24/21.
//

import Foundation

class APIConstant {
    
    
    static let baseURL = "https://spos.avocode.ae/api"
    static let posURL = baseURL + "/pos"
    static let sliders = baseURL + "/sliders"
    
    //AUTH
    static let login = baseURL + "/login"
    static let register = baseURL + "/register"
    static let sendCode = baseURL + "/send_code"
    static let verifyCode = baseURL + "/verify_code"
    static let resetPassword = baseURL + "/reset_password"
    static let logout = baseURL + "/logout"
    static let getPinCode = baseURL + "/pin_codes"
    static let postPinCode = baseURL + "/check_pin_code"
    static let submitTimeClock = baseURL + "/time_clock"
    
    //choose_store
    static let countries = baseURL + "/countries"
    static let myStores = posURL + "/my_stores"
    static let chooseStore = posURL + "/choose_store"
    static let myPOS = posURL + "/my_pos"
    static let choosePos = posURL + "/choose_pos"
    
    //CATEGORY
    static let getColors = baseURL + "/get_colors"
    static let addCategory = posURL + "/categories/store"
    static let getCategories = posURL + "/categories"
    static let showCategory = posURL + "/categories/show?category_id="
    static let deleteCategory = posURL + "/categories/delete?"
    static let getItemsWithCategory = getCategories + "/get_items"
    static let editCategory = posURL + "/categories/edit"
    
    
    static let getItems = getCategories + "/get_items"
    
    //ITEMS
    static let items = posURL + "/items"
    static let getModificationsAndTaxes = items + "/get_modifications_and_taxes"
    static let getModificationsAndTaxesNew = items + "/get_colors_categories_modifications_and_taxes"
    //{{url}}/api/pos/items/get_colors_categories_modifications_and_taxes?item_id=76&store_id=33
    
    
    static let addItem = items + "/store"
    static let getAllItems = posURL + "/items"
    static let showItem = posURL + "/items/show?item_id="
    static let deleteItem = posURL + "/items/delete"
    static let editItem = posURL + "/items/edit"
    static let getCategoriesWithoutPagination = posURL + "/items/get_categories"
    
    
    //DISCOUNTS
    static let getDiscounts = posURL + "/discounts"
    static let addDiscount = getDiscounts + "/store"
    static let deleteDiscount = posURL + "/discounts/delete"
    static let editDiscount = posURL + "/discounts/edit"
    
    
    //PROFILE
    static let profile = posURL + "/profile?pos_id="
    
    //SHIFT
    static let openShift = posURL + "/shifts/open_shift"
    static let closeShift = posURL + "/shifts/close_shift"
    static let showShift = posURL + "/shifts/show?shift_id="
    static let getCashManagements = posURL + "/shifts/get_cash_managements?shift_id="
    static let addCashManagements = posURL + "/shifts/add_cash_management"
    static let closeCashManagements = posURL + "/shifts/close_shift"
    
    
    //HOME
    static let getHome = posURL + "/home?pos_id="
    static let getHomeDetails = posURL + "/tickets/get_modifications_taxes_and_discounts"
    
    
    
    
    
    //TICKET
    static let addToTicket = posURL + "/tickets/store"
    static let showTicket = posURL + "/tickets/show/orders"
    static let clearTicket = posURL + "/tickets/delete?ticket_id="
    static let addOrEditCustomerTicket = posURL + "/tickets/add_customer"
    static let removeCustomerFromTicket = posURL + "/tickets/remove_customer?ticket_id="

    static let getTaxesFromTicket = posURL + "/tickets/get_taxes?ticket_id="
    static let deleteTaxesFromTicket = posURL + "/tickets/delete_taxes"
    
  
    
    //CUSTOMERS
    static let getCustomers = posURL + "/customers"
    static let addCustomers = posURL + "/customers/store"
    static let showCustomers = posURL + "/customers/show?customer_id="
    static let editCustomers = posURL + "/customers/edit"
    static let deleteCustomers = posURL + "/customers/delete?customer_id="
    
}

