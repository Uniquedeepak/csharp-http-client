.PHONY: clean test install release

clean:
	dotnet clean

install:
	@dotnet --version || (echo "Dotnet is not installed, please install Dotnet CLI"; exit 1);
	dotnet restore CSharpHTTPClient/CSharpHTTPClient.sln
	nuget install NUnit.Runners -Version 2.6.4 -OutputDirectory testrunner

test: install
	dotnet build ./CSharpHTTPClient/CSharpHTTPClient.csproj -c Release
	dotnet test ./UnitTest/UnitTest.csproj -c Release -f netcoreapp2.1
	curl -s https://codecov.io/bash > .codecov
	chmod +x .codecov
	./.codecov
