import Foundation

func keyDownCallback(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, refcon: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
    let sleepNum = UInt32.random(in: 500...65000)
    usleep(sleepNum)
    return Unmanaged.passRetained(event)
}

func startWhodis() {
    let keyEventMask = CGEventMask((1 << CGEventType.keyDown.rawValue) | (1 << CGEventType.keyUp.rawValue));
    guard let eventTap = CGEvent.tapCreate(
        tap: CGEventTapLocation.cgSessionEventTap,
        place: CGEventTapPlacement.headInsertEventTap,
        options: CGEventTapOptions.defaultTap,
        eventsOfInterest: keyEventMask,
        callback: keyDownCallback,
        userInfo: nil
        ) else {
            print("error creating event tap")
            exit(1)
    }

    let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, CFRunLoopMode.commonModes)
    CGEvent.tapEnable(tap: eventTap, enable: true)
    CFRunLoopRun()
}

func acquirePrivilegesOrStart() {
    let trusted = kAXTrustedCheckOptionPrompt.takeUnretainedValue()
    let privOptions = [trusted: true] as CFDictionary
    let enabled = AXIsProcessTrustedWithOptions(privOptions)
    if enabled {
        startWhodis()
    } else {
        print("missing necessary accessibility permissions")
        exit(1)
    }
}

acquirePrivilegesOrStart()
