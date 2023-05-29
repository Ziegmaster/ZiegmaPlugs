DeusdictumElements = DeusdictumDirectory .. ".Elements";
DeusdictumResources = string.gsub(DeusdictumDirectory, "%.", "/") .. "/Resources";

pcall( function( ) import (DeusdictumElements); end );