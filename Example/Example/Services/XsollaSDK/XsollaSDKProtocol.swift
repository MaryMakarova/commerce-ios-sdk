// Copyright 2021-present Xsolla (USA), Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at q
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing and permissions and

// swiftlint:disable function_parameter_count

import Foundation
import XsollaSDKInventoryKit
import XsollaSDKLoginKit
import XsollaSDKStoreKit

protocol XsollaSDKProtocol
{
    // MARK: - LoginKit
    
    func authByUsernameAndPassword(username: String,
                                   password: String,
                                   oAuth2Params: OAuth2Params,
                                   completion: @escaping LoginKitCompletion<String>)
    
    func authByUsernameAndPasswordJWT(username: String,
                                      password: String,
                                      clientId: Int,
                                      scope: String?,
                                      completion: ((Result<AccessTokenInfo, Error>) -> Void)?)
    
    func getLinkForSocialAuth(providerName: String,
                              oauth2params: OAuth2Params,
                              completion: @escaping LoginKitCompletion<URL>)
    
    func authBySocialNetwork(oAuth2Params: OAuth2Params,
                             providerName: String,
                             socialNetworkAccessToken: String,
                             socialNetworkAccessTokenSecret: String?,
                             socialNetworkOpenId: String?,
                             completion: @escaping LoginKitCompletion<String>)
    
    func generateJWT(grantType: TokenGrantType,
                     clientId: Int,
                     refreshToken: RefreshToken?,
                     clientSecret: String?,
                     redirectUri: String?,
                     authCode: String?,
                     completion: ((Result<AccessTokenInfo, Error>) -> Void)?)
    
    func registerNewUser(oAuth2Params: OAuth2Params,
                         username: String,
                         password: String,
                         email: String,
                         acceptConsent: Bool?,
                         fields: [String: String]?,
                         promoEmailAgreement: Int?,
                         completion: ((Result<URL?, Error>) -> Void)?)
    
    func resetPassword(loginProjectId: String,
                       username: String,
                       loginUrl: String?,
                       completion: ((Result<Void, Error>) -> Void)?)
    
    func startAuthByEmail(oAuth2Params: OAuth2Params,
                          email: String,
                          linkUrl: String?,
                          sendLink: Bool,
                          completion: ((Result<String, Error>) -> Void)?)
    
    func completeAuthByEmail(clientId: Int,
                             code: String,
                             email: String,
                             operationId: String,
                             completion: ((Result<String, Error>) -> Void)?)
    
    func startAuthByPhone(oAuth2Params: OAuth2Params,
                          phoneNumber: String,
                          linkUrl: String?,
                          sendLink: Bool,
                          completion: ((Result<String, Error>) -> Void)?)
    
    func completeAuthByPhone(clientId: Int,
                             code: String,
                             phoneNumber: String,
                             operationId: String,
                             completion: ((Result<String, Error>) -> Void)?)

    func getConfirmationCode(projectId: String,
                             login: String,
                             operationId: String,
                             completion: ((Result<String, Error>) -> Void)?)

    func resendConfirmationLink(clientId: Int,
                                redirectUri: String,
                                state: String,
                                username: String,
                                completion: ((Result<Void, Error>) -> Void)?)

    func authWithDeviceId(oAuth2Params: OAuth2Params,
                          device: String,
                          deviceId: String,
                          completion: ((Result<String, Error>) -> Void)?)
    
    func getUserConnectedDevices(completion: ((Result<[DeviceInfo], Error>) -> Void)?)
    
    func linkDeviceToAccount(device: String,
                             deviceId: String,
                             completion: ((Result<Void, Error>) -> Void)?)
    
    func unlinkDeviceFromAccount(deviceId: String,
                                 completion: ((Result<Void, Error>) -> Void)?)

    func addUsernameAndPassword(username: String,
                                password: String,
                                email: String,
                                promoEmailAgreement: Bool,
                                redirectUri: String?,
                                completion: ((Result<Bool, Error>) -> Void)?)

    func getCurrentUserDetails(completion: ((Result<UserProfileDetails, Error>) -> Void)?)
    
    func updateCurrentUserDetails(birthday: Date?,
                                  firstName: String?,
                                  lastName: String?,
                                  nickname: String?,
                                  gender: UserProfileDetails.Gender?,
                                  completion: ((Result<UserProfileDetails, Error>) -> Void)?)
    
    func getUserEmail(completion: ((Result<String?, Error>) -> Void)?)
    
    func deleteUserPicture(completion: ((Result<Void, Error>) -> Void)?)
    
    func uploadUserPicture(imageURL: URL, completion: ((Result<String, Error>) -> Void)?)
    
    func getCurrentUserPhone(completion: ((Result<String?, Error>) -> Void)?)
    
    func updateCurrentUserPhone(phoneNumber: String, completion: ((Result<Void, Error>) -> Void)?)
    
    func deleteCurrentUserPhone(phoneNumber: String, completion: ((Result<Void, Error>) -> Void)?)
    
    func getCurrentUserFriends(listType: FriendsListType,
                               sortType: FriendsListSortType,
                               sortOrderType: FriendsListOrderType,
                               after: String?,
                               limit: Int?,
                               completion: ((Result<FriendsList, Error>) -> Void)?)
    
    func updateCurrentUserFriends(actionType: FriendsListUpdateAction,
                                  userID: String,
                                  completion: ((Result<Void, Error>) -> Void)?)
    
    func getLinkedSocialNetworks(completion: ((Result<[UserSocialNetworkInfo], Error>) -> Void)?)
    
    func getSocialNetworkLinkingURL(for socialNetwork: SocialNetwork,
                                    callbackURL: String,
                                    completion: ((Result<URL, Error>) -> Void)?)
    
    func getClientUserAttributes(keys: [String]?,
                                 publisherProjectId: Int?,
                                 userId: String?,
                                 completion: ((Result<[UserAttribute], Error>) -> Void)?)
    
    func getClientUserReadOnlyAttributes(keys: [String]?,
                                         publisherProjectId: Int?,
                                         userId: String?,
                                         completion: ((Result<[UserAttribute], Error>) -> Void)?)
    
    func updateClientUserAttributes(attributes: [UserAttribute]?,
                                    publisherProjectId: Int?,
                                    removingKeys: [String]?,
                                    completion: ((Result<Void, Error>) -> Void)?)
    
    // MARK: - InventoryKit
    
    func getUserVirtualCurrencyBalance(
        projectId: Int,
        platform: String?,
        completion: @escaping InventoryKitCompletion<[InventoryVirtualCurrencyBalance]>)
    
    func getUserSubscriptions(projectId: Int,
                              platform: String?,
                              completion: @escaping InventoryKitCompletion<[InventoryUserSubscription]>)
    
    func consumeItem(projectId: Int,
                     platform: String?,
                     consumingItem: InventoryConsumingItem,
                     completion: @escaping InventoryKitCompletion<Void>)
    
    func getUserInventoryItems(projectId: Int,
                               platform: String?,
                               detailedSubscriptions: Bool?,
                               completion: @escaping InventoryKitCompletion<[InventoryItem]>)
    
    // MARK: - StoreKit
    
    func getItemGroups(projectId: Int, completion: @escaping StoreKitCompletion<[StoreItemGroup]>)
    
    func getVirtualItems(projectId: Int,
                         filterParams: StoreFilterParams,
                         completion: @escaping StoreKitCompletion<[StoreVirtualItem]>)
    
    func getVirtualCurrency(projectId: Int,
                            filterParams: StoreFilterParams,
                            completion: @escaping StoreKitCompletion<[StoreVirtualCurrency]>)
    
    func getVirtualCurrencyPackages(projectId: Int,
                                    filterParams: StoreFilterParams,
                                    completion: @escaping StoreKitCompletion<[StoreCurrencyPackage]>)
    
    func getItemsOfGroup(projectId: Int,
                         externalId: String,
                         filterParams: StoreFilterParams,
                         completion: @escaping StoreKitCompletion<[StoreVirtualItem]>)
    
    func getBundlesList(projectId: Int,
                        filterParams: StoreFilterParams,
                        completion: @escaping StoreKitCompletion<[StoreBundle]>)
    
    func getBundle(projectId: Int, sku: String, completion: @escaping StoreKitCompletion<StoreBundle>)
    
    func getOrder(projectId: Int,
                  orderId: String,
                  authorizationType: StoreAuthorizationType,
                  completion: @escaping StoreKitCompletion<StoreOrder>)
    
    func createOrder(projectId: Int,
                     itemSKU: String,
                     currency: String?,
                     locale: String?,
                     isSandbox: Bool,
                     paymentProjectSettings: StorePaymentProjectSettings?,
                     customParameters: [String: String]?,
                     completion: @escaping StoreKitCompletion<StoreOrderPaymentInfo>)
    
    func purchaseItemByVirtualCurrency(projectId: Int,
                                       itemSKU: String,
                                       virtualCurrencySKU: String,
                                       platform: String?,
                                       customParameters: Encodable?,
                                       completion: @escaping StoreKitCompletion<Int>)
    
    func redeemCoupon(projectId: Int,
                      couponCode: String,
                      selectedUnitItems: [String: String]?,
                      completion: @escaping StoreKitCompletion<[StoreCouponRedeemedItem]>)
    
    func getCouponRewards(projectId: Int,
                          couponCode: String,
                          completion: @escaping StoreKitCompletion<StoreCouponRewards>)
}
