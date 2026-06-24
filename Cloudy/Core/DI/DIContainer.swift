//
//  DIContainer.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 16/06/2026.
//

import Swinject

class DIContainer{
    static let shared = DIContainer()
    let container : Container
    
    private init(){
        self.container = Container()
        registerDependencies()
    }
    
    private func registerDependencies(){
        container.register(NetworkMangerProtocol.self) { _ in
            NetworkManger()
        }.inObjectScope(.container)
        
        container.register(WeatherRemoteDataSource.self) { r in
            let network = r.resolve(NetworkMangerProtocol.self)!
            return WeatherRemoteDataSource(network: network)
        }.inObjectScope(.container)
        
        container.register(WeatherRepoProtocol.self) { r in
            let dataSource = r.resolve(WeatherRemoteDataSource.self)!
            return WeatherRepo(dataSource: dataSource)
        }.inObjectScope(.container)
        
        container.register(LocationServiceProtocol.self) { _ in
            MainActor.assumeIsolated { LocationService() }
        }.inObjectScope(.container)

        container.register(HomeViewModel.self) { r in
            let repo = r.resolve(WeatherRepoProtocol.self)!
            let locationService = r.resolve(LocationServiceProtocol.self)!
            return HomeViewModel(repo: repo, locationService: locationService)
        }.inObjectScope(.container)

        container.register(LocationSearchViewModel.self) { r in
            let repo = r.resolve(WeatherRepoProtocol.self)!
            return LocationSearchViewModel(repo: repo)
        }.inObjectScope(.transient)
    }
}
