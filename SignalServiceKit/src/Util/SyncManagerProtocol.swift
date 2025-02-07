//
// Copyright 2019 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

import Foundation

@objc
public protocol SyncManagerProtocol: SyncManagerProtocolObjc, SyncManagerProtocolSwift {}

// MARK: -

@objc
public protocol SyncManagerProtocolObjc {
    func sendConfigurationSyncMessage()

    typealias Completion = () -> Void

    func syncLocalContact() -> AnyPromise
    func syncAllContacts() -> AnyPromise
    @discardableResult
    func syncAllContactsIfFullSyncRequested() -> AnyPromise

    func processIncomingConfigurationSyncMessage(_ syncMessage: SSKProtoSyncMessageConfiguration, transaction: SDSAnyWriteTransaction)
    func processIncomingContactsSyncMessage(_ syncMessage: SSKProtoSyncMessageContacts, transaction: SDSAnyWriteTransaction)
    func processIncomingFetchLatestSyncMessage(_ syncMessage: SSKProtoSyncMessageFetchLatest, transaction: SDSAnyWriteTransaction)

    func sendFetchLatestProfileSyncMessage()
    func sendFetchLatestStorageManifestSyncMessage()
    func sendFetchLatestSubscriptionStatusSyncMessage()
}

// MARK: -

@objc
public protocol SyncManagerProtocolSwift {
    func sendAllSyncRequestMessagesIfNecessary() -> AnyPromise
    func sendAllSyncRequestMessages(timeout: TimeInterval) -> AnyPromise

    func sendKeysSyncMessage()
    func processIncomingKeysSyncMessage(_ syncMessage: SSKProtoSyncMessageKeys, transaction: SDSAnyWriteTransaction)
    func sendKeysSyncRequestMessage(transaction: SDSAnyWriteTransaction)

    func processIncomingMessageRequestResponseSyncMessage(
        _ syncMessage: SSKProtoSyncMessageMessageRequestResponse,
        transaction: SDSAnyWriteTransaction
    )
    func sendMessageRequestResponseSyncMessage(thread: TSThread, responseType: OWSSyncMessageRequestResponseType)
    func sendMessageRequestResponseSyncMessage(thread: TSThread, responseType: OWSSyncMessageRequestResponseType, transaction: SDSAnyWriteTransaction)
}
