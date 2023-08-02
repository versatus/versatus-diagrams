// https://structurizr.com/share/28201

workspace extends ../model.dsl {
    name "vrrb - System Landscape"
    description "The system landscape for vrrb."

    model {
        !ref vrrbBlockchain {
            url https://structurizr.com/share/36141/diagrams#SystemContext
        }
    }

    views {
        systemlandscape "SystemLandscape" {
            include *
        }

        styles {
            element "Person" {
                color #ffffff
                fontSize 22
                shape Person
            }
            element "Customer" {
                background #08427b
            }
            element "Bank Staff" {
                background #999999
            }
            element "Software System" {
                background #999999
                color #ffffff
            }
        }
    }

}