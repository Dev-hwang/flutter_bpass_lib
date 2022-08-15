package com.pravera.flutter_bpass_lib.models

import java.util.*

data class RequestData(
    val state: String,
    val type: Int,
    val dataHash: String?,
    val did: String?
    ) {
    companion object {
        fun fromMap(map: Map<*, *>?): RequestData {
            val state = map?.get("state") as? String ?: UUID.randomUUID().toString()
            val type = map?.get("type") as? Int ?: 0
            val dataHash = map?.get("dataHash") as? String
            val did = map?.get("did") as? String

            return RequestData(
                state = state,
                type = type,
                dataHash = dataHash,
                did = did
            )
        }
    }
}
