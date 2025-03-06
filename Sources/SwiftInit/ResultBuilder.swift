//
//  ParameterBuilder.swift
//  CoreKit
//
//  Created by yungui chen on 2024/10/9.
//


@resultBuilder
public final class ParameterBuilder: BaseBuilder<Parameter> {
}

@resultBuilder
public final class ParameterDeclBuilder: BaseBuilder<ParameterDecl> {
}

@resultBuilder
public final class CodeBuilder: BaseBuilder<Optional<CodeConvertible>> {
}

@resultBuilder
public final class DeclBuilder: BaseBuilder<DeclConvertible> {
}

@resultBuilder
public final class InstanceOperationBuilder: BaseBuilder<InstanceOperation> {
}

@resultBuilder
public final class InlineOperationBuilder: BaseBuilder<InlineOperation> {
}

@resultBuilder
public final class StringBuilder: BaseBuilder<String> {
}

@resultBuilder
public final class MethodBuilder: BaseBuilder<Optional<MethodCall>> {
}

open class BaseBuilder<E> {
    public typealias Expression = E
    public typealias Component = [E]
    
    // If Component were "any Collection of HTML", we could have this return
    // CollectionOfOne to avoid an array allocation.
    public static func buildExpression(_ expression: Expression) -> Component {
      return [expression]
    }

    // Build a combined result from a list of partial results by concatenating.
    //
    // If Component were "any Collection of HTML", we could avoid some unnecessary
    // reallocation work here by just calling joined().
    public static func buildBlock(_ children: Component...) -> Component {
      return children.flatMap { $0 }
    }

    // We can provide this overload as a micro-optimization for the common case
    // where there's only one partial result in a block.  This shows the flexibility
    // of using an ad-hoc builder pattern.
    public static func buildBlock(_ component: Component) -> Component {
      return component
    }
    
//    public static func buildBlock(_ expresss: Expression...) -> Component {
//        return Array(expresss)
//    }
    
    // Handle optionality by turning nil into the empty list.
    public static func buildOptional(_ children: Component?) -> Component {
      return children ?? []
    }

    // Handle optionally-executed blocks.
    public static func buildEither(first child: Component) -> Component {
      return child
    }
    
    // Handle optionally-executed blocks.
    public static func buildEither(second child: Component) -> Component {
      return child
    }
    
    public static func buildArray(_ components: [Component]) -> Component {
        components.flatMap{ $0 }
    }
}
