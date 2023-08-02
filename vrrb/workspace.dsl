workspace "VRRB Blockchain" {
    model {
        customer = person "User" "[External Actor]" "User"
        security = softwaresystem "Security" "The \"Security Layer \" , a subset of nodes that ensure \n the integrity of global state by executing validation protocols.\n\n [System: SSL padlock]"
        execution = softwaresystem "Execution" "The Execution layer,where nodes pass data \n executes programs and receives return data to update state. if valid.\n\n [System Gear - AWS]"
        global_state = softwaresystem "Global State" "\n\n [Generic Database]"
        group "vrrb" {
            dapp = softwaresystem "dApp" "\n A generic decentralized application in the network.Consists of UI that interfaces with wallet and programs in network. \n\n [External system : Generic Application ]"
            wallet = softwaresystem "Wallet App" "\n A generic wallet application which provides a user interface to communicate with network.\n\n[External System : Generic Application]"
            rdht = softwaresystem "Rendzevous DHT " "The Rendezvous DHT protocol based on threshold cryptography is a    protocol in which nodes can communicate and share information of the Quorum Peers without relying on a single centralized authority."
            relay = softwaresystem "Relay" "A relay service that forwards messages to the network, typically via RPC ,but could also use direct transport layers. \n\n [External System : Internet alt2]"
            vrrb = softwaresystem "VRRB" ""
        }

        # relationships between people and software systems
        customer -> wallet "User--->Wallet"
        wallet -> customer "Wallet--->User"
        wallet -> dapp "Wallet--->dApp"
        wallet -> relay "Wallet--->Relay"
        relay -> wallet "Relay--->Wallet"
        dapp -> relay "dApp-->Relay-->Network"
        relay -> rdht "Register Peer Membership, Get active Quorum Peers"
        security -> execution "Security-->Execution"
        security -> global_state "Security-->Global State"
        global_state -> security "Global State-->Security"

        relay -> security "Relay--->Network"
    }

    views {
        systemcontext vrrb "SystemContext" {
            include wallet
            include customer
            include dapp
            include global_state
            include security
            include execution
            include relay
            include rdht
            animation {
                relay
                customer
                wallet
                dapp
            }
            description "The system context diagram for the VRRB Blockchain."
            properties {
                structurizr.groups false
            }
        }

        styles {
            element "Person" {
                color #ffffff
                fontSize 22
                shape Person
            }
            element "User" {
                background #08427b
            }
            element "Software System" {
                background #1168bd
                color #ffffff
                shape RoundedBox
            }
            element "Existing System" {
                background #999999
                color #ffffff
                shape RoundedBox
            }
        }
    }
}
