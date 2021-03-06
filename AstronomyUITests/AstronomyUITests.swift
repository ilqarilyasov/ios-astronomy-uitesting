//
//  AstronomyUITests.swift
//  AstronomyUITests
//
//  Created by Ilgar Ilyasov on 10/18/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest

class AstronomyUITests: XCTestCase {
    
    override func setUp() {
        
        let app = XCUIApplication()
        app.launchArguments = ["UITesting"] // The App will look for to know that it use local data instead of making network calls IMPORTANT !!!
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let app = XCUIApplication()
        
        // Tap on Navigation Item Title
        XCUIApplication().navigationBars["Sol 1"].otherElements["Sol 1"].tap()
        
        
        // Tap on PhotosCollectionVC Image
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"PhotosCollectionViewController.ImageView").element.tap()
        
        
        // Tap on PhotoDetailVC Image
        app.otherElements.containing(.navigationBar, identifier:"Title").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        
        // Tap on Detail Label
        XCUIApplication().otherElements.containing(.navigationBar, identifier:"Title").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        
        // Tap on Camera Label
        XCUIApplication().staticTexts["PhotoDetailViewController.CameraLabel"].tap()
        
        // Tap on PhotoDetailVC Save to Photo Library Button
        app/*@START_MENU_TOKEN@*/.buttons["PhotoDetailViewController.SaveButton"]/*[[".buttons[\"Save to Photo Library\"]",".buttons[\"PhotoDetailViewController.SaveButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Tap on PhotoDetailVC Alert Okay Button
        app.alerts["Photo Saved!"].buttons["Okay"].tap()
        
        // Tap on PhotoDetailVC Back button
        XCUIApplication().navigationBars["Title"].buttons["Sol 1"].tap()
        
        // PhotosCollectionVC Next Sol
        XCUIApplication().navigationBars["Sol 1"]/*@START_MENU_TOKEN@*/.buttons["PhotosCollectionViewController.NextSolButton"]/*[[".buttons[\">\"]",".buttons[\"PhotosCollectionViewController.NextSolButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // PhotosCollectionVC Previous Sol
        XCUIApplication().navigationBars["Sol 2"]/*@START_MENU_TOKEN@*/.buttons["PhotosCollectionViewController.PreviousSolButton"]/*[[".buttons[\"<\"]",".buttons[\"PhotosCollectionViewController.PreviousSolButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // PhotosCollectionVC Scroll Down
        XCUIApplication().otherElements.containing(.navigationBar, identifier:"Sol 1").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.swipeUp()
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testImageLoads() {
        PhotosCollectionPage(testCase: self)
        .tapOnImageView(index: 0, file: #file, line: #line)
    }
    
    func testNextSol() {
        PhotosCollectionPage(testCase: self)
        .tapOnRightBarButton()
        .verifySolChanged(index: 0, file: #file, line: #line)
    }
    
    func testPreviousSol() {
        PhotosCollectionPage(testCase: self)
        .tapOnRightBarButton()
        .tapOnLeftBarButton()
        .verifySolChanged(index: 1, file: #file, line: #line)
        
    }
    
    func testImageTappedAndDetailOpened() {
        PhotosCollectionPage(testCase: self)
            .tapOnImageView(index: 0, file: #file, line: #line)
            .verifyDetailsExist(file: #file, line: #line)
    }
    
    func testPhotoSaved() {
        PhotosCollectionPage(testCase: self)
        .tapOnImageView(index: 0)
        .verifyDetailsExist(file: #file, line: #line)
        .saveButtonTapped()
        .verifyAlertShown()
        .tapOkayButton()
    }

}
