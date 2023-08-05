workspace {
    name "DealerLess Distributed Key Generation"
    description "DealerLess Distributed Key Generation for Quorum Formation"

    model {
        n = softwareSystem "Node"

        current_node = softwaresystem "CNode" "Current Node Participating in DKG" {
                webApplication = container "Web Application" "Delivers the static content and the Internet banking single page application." "Java and Spring MVC"
                node_container = container "Node Components" "Contains all components within system that contributes to DKG" {
                node_component = component "Node module" "Participating in Quorum Election"
                quorum_component = component "Quorum Module" "Conducts Proof Of Claim Quorum Election in decentralized way"
                consensus_component = component "Consenus Module " "Interacts with DKG Engine"
                dkg_engine = component "Dkg Engine" "DKG Engine"
                dkg_storage = component "DKG Storage" "Stores part committment within Dkg Storage"

                }
                global_state = container "GlobalState" "Global State Store"{
                     tags "Database"
                }
                network = container "VRRB" "VRRB Network"{
                     tags "Network"
                }
                rdht = container "RHDT" "Rendzevous DHT"{
                     tags "Database"
                }

        }
        node_component -> global_state {
            tags "rel"
        }
        node_component -> quorum_component
        quorum_component -> consensus_component
        consensus_component -> dkg_engine
        dkg_engine -> dkg_storage
        dkg_engine -> network {
            tags "rel"
        }
        network -> dkg_engine {
            tags "rel"
        }
        dkg_engine -> node_component
        dkg_engine -> rdht
        s = softwareSystem "DealerLess Distributed Key Generation" {
            node = container "Node" {
                quorum = component "Quorum"
                consensus = component "Consensus" "Provides Internet banking functionality via a JSON/HTTPS API." "Java and Spring MVC"

                dkgEngine = component "DkgEngine"
            }
            database = container "VRRB DKG Engine Storage" {
                tags "Database"
            }
            p2p_network = container "VRRB Network" {
                tags "Network"
            }
            consensus_module = container "DKG" "Responsible for creating DKG for Elected Quorum "

        }

        n -> quorum "Runs Election using Proof of Claim"{
            tags "rel"
        }
        quorum -> consensus "Initiate DKG Process"{
            tags "rel"
        }
        consensus -> dkgEngine "Runs DKG Process"{
            tags "rel"
        }
        consensus -> database "Reads from and writes to"{
            tags "rel"
        }
        dkgEngine -> p2p_network "Broadcast the Part Committments to members of Quorum" {
            tags "rel"
        }
        p2p_network -> dkgEngine "Receive the Part Committments from members of the Quorum"{
             tags "rel"
        }

        dkgEngine -> p2p_network "Ack the part Committments of peers and broadcast it to peers Quorum" {
            tags "rel"
        }
        p2p_network -> dkgEngine "Receive the ack of part Committments from other members of the Quorum"{
             tags "rel"
        }
        dkgEngine -> consensus "Generate DKG"{
             tags "rel"
        }
    }

    views {
        component node {
            include *
        }

       dynamic consensus_module  "dkg" "Summarises DKG will be created" {

            node_component -> global_state "Fetch Claims from Global State"
            node_component -> quorum_component "Quorum Election"
            quorum_component -> consensus_component "Initiate DKG"
            consensus_component -> dkg_engine "Initiatilize SyncGen Instance and Generate Part Committment"
            dkg_engine -> dkg_storage "Store the current part committment into DKG storage"
            dkg_engine -> network "Broadcast the part committment across the vrrb network "
            network -> dkg_engine "Receive part committments from the neighbouring
            dkg_engine -> dkg_storage "Ack the part committment of neihbour and store it in the dkg storage"
            dkg_engine -> network "Broadcast the ack of part committment across the vrrb network "
            network -> dkg_engine "Once all ack committments are recieved ,handle all acks, Generate DKG"
            dkg_engine -> node_component "Broadcast Quorum Key to all the components"
            dkg_engine -> rdht "Register the Quorum Key with RDHT"
            description "Summarises how DKG is formed after Quorum Election"
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
            element "GlobalState" {
                background #438dd5
                color #ffffff
                shape Cylinder
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "Container" {
                color #ff0000
            }

            element "network" {
                background #1168bd
                color #ffffff
                shape Hexagon
            }
            relationship "rel" {
                thickness 2
                routing orthogonal
                style solid
                colour #000000
             }


    }
}
