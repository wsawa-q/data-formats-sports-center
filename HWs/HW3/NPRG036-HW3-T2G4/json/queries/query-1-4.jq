[ [ .[] | { "@type", "@id" } ] | group_by(."@type")[] | {(.[0]."@type"): [.[] | ."@id"]} ]