#!/bin/bash

#   YouTalk  Copyright (C) 2024-2025  Aptivi
#  
#   This file is part of YouTalk
#  
#   YouTalk is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#  
#   YouTalk is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY, without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#  
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Convenience functions
checkerror() {
    if [ $1 != 0 ]
    then
        printf "$2 - Error $1\n" >&2
        exit $1
    fi
}

# This script pushes. Use when you have dotnet installed.
releaseconf=$1
if [ -z $releaseconf ]; then
	releaseconf=Release
fi
dotnetpath=`which dotnet`
checkerror $? "dotnet is not found"

# Push packages
echo Pushing packages...
find .. -type f -path "*/bin/$releaseconf/*.nupkg" -exec dotnet nuget push {} --api-key $NUGET_APIKEY --source "nuget.org" \;
checkerror $? "Failed to push"

# Inform success
echo Push successful.
exit 0