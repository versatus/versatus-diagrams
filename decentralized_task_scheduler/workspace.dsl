workspace {
    name "Decentralized Task Scheduler"
    description "Decentralized Task Scheduler"
    model {

        n = softwareSystem "RPC Node"
        s = softwareSystem "Decentralized Task Scheduler" {
            farmer_node = container "Farmer Node" {
                farmer = component "Farmer"
                event_router = component "Event Router"
                farmer_scheduler = component "Decentralized Task Scheduler"
                farmer_local_job_pool = component "Local Job Pool"
                farmer_remote_job_pool = component "Remote Job Pool"
                farmer_forwarding_job_pool = component "Forwarding Job Pool"
                farmer_txn_validator = component "Txn Validator"
                farmer_claim_validator = component "Claim Validator"
                farmer_mempool = component "Left Right Mempool" {
                    tags "Mempool"
                }
            }
            database = container "Versatus Integral DB" {
                tags "Database"
            }
            p2p_network = container "VRRB Network" {
                tags "Network"
            }

        }

        n -> farmer "Initiate a request to insert the transaction into the Left Right Mempool." {
            tags "rel"
        }
        farmer -> farmer_mempool "Add the transaction to the Left Right Mempool, contingent upon it being processed by the current Farmer Quorum." {
            tags "rel"
        }

        farmer_mempool -> farmer "Retrieve pending transactions from the Left Right Mempool for voting." {
            tags "rel"
        }

        farmer -> farmer_scheduler "Dispatch a job of Transaction Validation to the Scheduler." {
            tags "rel"
        }
        database -> farmer "Retrieve the claims data or account data of both the sender and receiver." {
            tags "rel"
        }
        farmer_local_job_pool -> farmer_txn_validator {
            tags "rel"
        }
        farmer_local_job_pool -> farmer_claim_validator {
            tags "rel"
        }
        farmer_scheduler -> farmer "Generate a vote (Yes/No) for the transaction, accompanied by a partial signature." {
            tags "rel"
        }
        farmer_scheduler -> farmer_local_job_pool "Dispatch the task to the Local Pool for execution if the required data dependencies are available within the node itself." {
            tags "rel"
        }
        farmer_scheduler -> farmer_remote_job_pool "If data dependencies are located outside the node, dispatch the task to the Remote Pool for execution." {
            tags "rel"
        }
        farmer_scheduler -> farmer_forwarding_job_pool "If there is a high backpressure, transmit the transaction to the forwarding pool." {
            tags "rel"
        }
        farmer_forwarding_job_pool -> p2p_network "If the current node experiences excessive backpressure, broadcast the transaction to another quorum." {
            tags "rel"
        }
        farmer_local_job_pool -> event_router "Transmit the output of the job, which was executed by the local job pooler." {
            tags "rel"
        }
        farmer_remote_job_pool -> p2p_network "Request the data dependencies from neighboring Quorums." {
            tags "rel"
        }
        p2p_network -> farmer_remote_job_pool "Retrieve the data dependencies from neighboring Quorums." {
            tags "rel"
        }
        farmer_remote_job_pool -> event_router "Transmit the output of the job, which was executed by the remote job pooler." {
            tags "rel"
        }
        farmer -> p2p_network "Broadcast the transaction to neighboring Quorums, as the current Farmer Quorum is not intended to process the transaction according to the Maglev Hash Ring." {
            tags "rel"
        }
    }

    views {
        component farmer_node {
            include *
        }
        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
                shape RoundedBox
            }
            element "Database" {
                background #438dd5
                color #ffffff
                shape Cylinder
            }
            element "Network" {
                background #438dd5
                color #ffffff
                shape Hexagon
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "Container" {
                color #ff0000
            }
            element "Mempool" {
                background #1168bd
                color #ffffff
                shape Cylinder
                description true
            }
            relationship "rel" {
                thickness 2
                routing curved
                style solid
                colour #000000
            }
        }
    }
}
