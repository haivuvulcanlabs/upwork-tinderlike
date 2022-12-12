//
//  PurchaseViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 11/12/2022.
//

import Foundation
import StoreKit

class PurchaseViewModel : ObservableObject {
    static let shared = PurchaseViewModel()
    
    @Published var items: [StoreItem] = []
    @Published var isLoading = false
    @Published var selectedItem: StoreItem?
    
    func loadProducts() {
        
        InAppPurchaseProducts.productIDs = ["co.upworkmatch.monthly1", "co.upworkmatch.monthly6", "co.upworkmatch.monthly12"]
        
        
        InAppPurchaseProducts.store.requestProducts { success, products in
            if success {
                InAppPurchaseProducts.store.products = products ?? []
                print("APP-IN-PURCHASE",products ?? [])
            }
        }
        
    }
    
    func getStoreConfigs() -> [StoreConfig] {
        guard let url = Bundle.main.url(forResource: "StoreConfigs", withExtension: "json")
        else {
            return []
        }
        guard let data = try? Data(contentsOf: url) else { return [] }
        
        let string = String(data: data, encoding: .utf8)
        
        
        
        do {
            // process data
            let items: [StoreConfig] = try JSONDecoder().decode([StoreConfig].self, from: data)
            debugPrint("hai iap configs \(string) --\n \(items)")
            
            return items
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("hai iap configs Key '\(key)' not found:", context.debugDescription)
            print("hai iap configs codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("hai iap configs Value '\(value)' not found:", context.debugDescription)
            print("hai iap configs codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("hai iap configs Type '\(type)' mismatch:", context.debugDescription)
            print("hai iap configs codingPath:", context.codingPath)
        } catch {
            print("hai iap configs error: ", error)
        }
        
        return []
    }
    
    func getCoinPlans() {
        let configs = getStoreConfigs()
        
        debugPrint("hai iap \(configs) ->\(InAppPurchaseProducts.store.products.compactMap({$0.productIdentifier}))")
        for config in configs {
            if let product = InAppPurchaseProducts.store.products.first(where: {$0.productIdentifier == config.productID}) {
                let item = StoreItem(config: config, product: product)
                
                items.append(item)
            }
        }
        
        selectedItem = items.first(where: {$0.promoted})
    }
    
    
    func purchasePlan(plan: StoreConfig,complition: @escaping (_ status : Bool) -> ()) {
        
        let key = plan.productID ?? ""
        for product in AllStaticData.purchaseStorkit {
            if product.productIdentifier == key {
                isLoading = true
                print(product)
                InAppPurchaseProducts.store.buyProduct(product) { [self] success, productId in
                    isLoading = false
                    guard success else {
                        complition(false)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            //                            Functions.share.makeToast(title: LocalStrings.paymentFail.localized())
                        }
                        return
                    }
                    //                    CoinManager.shared.plusCoin(coin: plan.coinAmount ?? 0, toUserID: AllStaticData.userID, type: .in_app_purchase,price: plan.coinAmount ?? 0,summury:  productId ?? "unknown") { status in
                    //                        self.isLoading = false
                    //                        complition(true)
                    //                    }
                }
                break
            }
        }
    }
    
    func onSelectItem(_ item: StoreItem) {
        selectedItem = item
    }
    
    func onPurchased(item: StoreItem?,complition: @escaping (_ status : Bool) -> ()) {
        guard let item = item else {
            return
        }
        
        for product in InAppPurchaseProducts.store.products {
            if product.productIdentifier == item.product.productIdentifier {
                isLoading = true
                print(product)
                InAppPurchaseProducts.store.buyProduct(product) { [self] success, productId in
                    isLoading = false
                    guard success else {
                        complition(false)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            //                            Functions.share.makeToast(title: LocalStrings.paymentFail.localized())
                        }
                        return
                    }
                    //                    CoinManager.shared.plusCoin(coin: plan.coinAmount ?? 0, toUserID: AllStaticData.userID, type: .in_app_purchase,price: plan.coinAmount ?? 0,summury:  productId ?? "unknown") { status in
                    //                        self.isLoading = false
                    //                        complition(true)
                    //                    }
                    complition(true)
                }
                break
            }
        }
    }
}
