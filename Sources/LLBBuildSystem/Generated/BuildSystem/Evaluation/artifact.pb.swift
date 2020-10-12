// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: BuildSystem/Evaluation/artifact.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

// This source file is part of the Swift.org open source project
//
// Copyright (c) 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors

import Foundation
import SwiftProtobuf

import TSFCAS
import llbuild2

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

/// An Artifact is the unit with which files and directories are represented in llbuild2. It contains not the contents
/// of the sources or intermediate files and directories, but instead contains the necessary data required to resolve
/// a particular input (or output) artifact during execution time. In some ways, it can be viewed as a future where
/// the result (ArtifactValue) is a reference to the actual built contents of the artifact.
public final class LLBArtifact {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Represents what type of Artifact reference this is.
  public var originType: LLBArtifact.OneOf_OriginType? = nil

  /// Source artifacts are inputs to the build, and as such, have a known dataID at the beginning of the build.
  public var source: TSFCAS.LLBDataID {
    get {
      if case .source(let v)? = originType {return v}
      return TSFCAS.LLBDataID()
    }
    set {originType = .source(newValue)}
  }

  /// Derived artifacts are produced by actions, referenced in the LLBArtifactOwner object.
  public var derived: LLBArtifactOwner {
    get {
      if case .derived(let v)? = originType {return v}
      return LLBArtifactOwner()
    }
    set {originType = .derived(newValue)}
  }

  /// Derived static artifacts are artifacts populated directly in the rule implementation, such as file writes
  /// that do not require a heavyweight action to run.
  public var derivedStatic: TSFCAS.LLBDataID {
    get {
      if case .derivedStatic(let v)? = originType {return v}
      return TSFCAS.LLBDataID()
    }
    set {originType = .derivedStatic(newValue)}
  }

  /// A short path representation of the artifact. This usually includes the configuration independent paths.
  public var shortPath: String = String()

  /// A list of root under which to make the short path relative to. This usually includes configuration elements to
  /// use for deduplication when the a target is evaluated multiple times during a build under different
  /// configurations.
  public var roots: [String] = []

  /// The type of artifact that this represents.
  public var type: llbuild2.LLBArtifactType = .file

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  /// Represents what type of Artifact reference this is.
  public enum OneOf_OriginType: Equatable {
    /// Source artifacts are inputs to the build, and as such, have a known dataID at the beginning of the build.
    case source(TSFCAS.LLBDataID)
    /// Derived artifacts are produced by actions, referenced in the LLBArtifactOwner object.
    case derived(LLBArtifactOwner)
    /// Derived static artifacts are artifacts populated directly in the rule implementation, such as file writes
    /// that do not require a heavyweight action to run.
    case derivedStatic(TSFCAS.LLBDataID)

  #if !swift(>=4.1)
    public static func ==(lhs: LLBArtifact.OneOf_OriginType, rhs: LLBArtifact.OneOf_OriginType) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.source, .source): return {
        guard case .source(let l) = lhs, case .source(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.derived, .derived): return {
        guard case .derived(let l) = lhs, case .derived(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.derivedStatic, .derivedStatic): return {
        guard case .derivedStatic(let l) = lhs, case .derivedStatic(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      default: return false
      }
    }
  #endif
  }

  public init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension LLBArtifact: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = "LLBArtifact"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "source"),
    5: .same(proto: "derived"),
    6: .same(proto: "derivedStatic"),
    2: .same(proto: "shortPath"),
    3: .same(proto: "roots"),
    4: .same(proto: "type"),
  ]

  public func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try {
        var v: TSFCAS.LLBDataID?
        if let current = self.originType {
          try decoder.handleConflictingOneOf()
          if case .source(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.originType = .source(v)}
      }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.shortPath) }()
      case 3: try { try decoder.decodeRepeatedStringField(value: &self.roots) }()
      case 4: try { try decoder.decodeSingularEnumField(value: &self.type) }()
      case 5: try {
        var v: LLBArtifactOwner?
        if let current = self.originType {
          try decoder.handleConflictingOneOf()
          if case .derived(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.originType = .derived(v)}
      }()
      case 6: try {
        var v: TSFCAS.LLBDataID?
        if let current = self.originType {
          try decoder.handleConflictingOneOf()
          if case .derivedStatic(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.originType = .derivedStatic(v)}
      }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if case .source(let v)? = self.originType {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if !self.shortPath.isEmpty {
      try visitor.visitSingularStringField(value: self.shortPath, fieldNumber: 2)
    }
    if !self.roots.isEmpty {
      try visitor.visitRepeatedStringField(value: self.roots, fieldNumber: 3)
    }
    if self.type != .file {
      try visitor.visitSingularEnumField(value: self.type, fieldNumber: 4)
    }
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every case branch when no optimizations are
    // enabled. https://github.com/apple/swift-protobuf/issues/1034
    switch self.originType {
    case .derived?: try {
      guard case .derived(let v)? = self.originType else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    }()
    case .derivedStatic?: try {
      guard case .derivedStatic(let v)? = self.originType else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    }()
    default: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: LLBArtifact, rhs: LLBArtifact) -> Bool {
    if lhs.originType != rhs.originType {return false}
    if lhs.shortPath != rhs.shortPath {return false}
    if lhs.roots != rhs.roots {return false}
    if lhs.type != rhs.type {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
