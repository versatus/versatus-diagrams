workspace {

    !identifiers hierarchical

    model {

        miner = softwareSystem "Miner"
        softwareSystem = softwareSystem "Convergence Block Certification Protocoll"{

            harvester1 = group "Harvester 1" {
                harvester1Api = container "Harvester 1 API" {
                    tags "Harvester 1" "Harvester API"
                }
                container "Harvester 1 Global State" {
                    tags "Harvester 1" "Database"
                    harvester1Api -> this "4. Threshold Signs Convergence Block and update Global state and broadcast the block"
                }
            }



            harvester2 = group "Harvester 2" {
                harvester2Api = container "Harvester 2 API" {
                    tags "Harvester 2" "Harvester API"
                }
                container "Harvester 2 Global State" {
                    tags "Harvester 2" "Database"
                    harvester2Api -> this "4. Threshold Signs Convergence Block and update Global state and broadcast the block"
                }
            }

            harvester3 = group "Harvester 3" {
                harvester3Api = container "Harvester 3 API" {
                    tags "Harvester 3" "Harvester API"
                }
                container "Harvester 3 Global State" {
                    tags "Harvester 3" "Database"
                    harvester3Api -> this "4. Threshold Signs Convergence Block and update Global state and broadcast the block"
                }

            }
            harvester1Api -> harvester2Api "1. Broadcast Proposal Block consisting of Transactions" {
                tags "rel"
            }
            harvester1Api -> harvester3Api "1. Broadcast Proposal Block consisting of Transactions"{
                tags "rel"
            }
             harvester3Api -> harvester1Api "1. Broadcast Proposal Block consisting of Transactions"{
                tags "rel"
            }
              harvester3Api -> harvester2Api "1. Broadcast Proposal Block consisting of Transactions"{
                tags "rel"
            }
            harvester2Api -> harvester1Api "1. Broadcast Proposal Block consisting of Transactions"{
                tags "rel"
            }
            harvester2Api -> harvester3Api "1. Broadcast Proposal Block consisting of Transactions"{
                tags "rel"
            }

            harvester1Api -> miner "1. Broadcast Proposal Block consisting of Transactions"{
                tags "rel"
            }
            miner -> harvester2Api "2. Mines Convergence Block send Convergence block for signing"{
                tags "rel"
            }
            miner -> harvester3Api "2. Mines Convergence Block send Convergence block for signing"{
                tags "rel"
            }

              harvester1Api -> harvester2Api "3. Broadcast Partial Signature among harvesters"{
                            tags "rel"
               }
               harvester1Api -> harvester3Api "3. Broadcast Partial Signature among harvesters"{
                                           tags "rel"
                }
               harvester2Api -> harvester1Api "3. Broadcast Partial Signature among harvesters"{
                                                          tags "rel"
                 }
             harvester2Api -> harvester3Api "3. Broadcast Partial Signature among harvesters"{
                                                                        tags "rel"
             }
            harvester3Api -> harvester1Api "3. Broadcast Partial Signature among harvesters"{
                                                                        tags "rel"
             }
            harvester3Api -> harvester2Api "3 Broadcast Partial Signature among harvesters"{
                                                                         tags "rel"
              }


        }
         network = softwareSystem  "VRRB" "VRRB Network"{
                             tags "Network"
             }

    }

    views {
        container softwareSystem "Containers_All" {
            include *
          //  autolayout
        }



        styles {
            element "Person" {
                shape Person
            }
            element "Service API" {
                shape hexagon
            }
            element "Database" {
                shape cylinder
            }
            element "Farmer 1" {
                background #91F0AE
            }
            element "Harvester 1" {
                background #91F0AE
            }
            element "Harvester 2" {
                background #EDF08C
            }
            element "Harvester 3" {
                background #8CD0F0
            }
             element "Network" {
                            background #438dd5
                            color #ffffff
                            shape Hexagon
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

