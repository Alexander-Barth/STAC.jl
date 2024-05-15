using Test
using Dates
using STAC

timerange = (DateTime(2019,1,1),DateTime(2019,12,31))
collection_concept_id = "C1996881146-POCLOUD"
baseurl = "https://cmr.earthdata.nasa.gov/search/granules.stac"

query = Dict(
    "collection_concept_id" => collection_concept_id,
    "temporal" => join(string.(timerange),','),
    "pageSize" => 1000,
)

url = baseurl
collection = STAC.FeatureCollection(url,query)

opendap_url = [href(item.assets["opendap"]) for item in collection]
@test length(opendap_url) == 365
