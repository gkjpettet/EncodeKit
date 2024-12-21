#tag Module
Protected Module EncodeKit
	#tag Method, Flags = &h0, Description = 52657475726E732074686520636F6E7374727563746F7220666F72207468652073706563696669656420636C61737320776974682060636F756E746020706172616D6574657273206F72204E696C2069662074686572652069736E2774206F6E652E
		Function ConstructorWithParameterCount(Extends ti As Introspection.TypeInfo, count As Integer) As Introspection.ConstructorInfo
		  /// Returns the constructor for the specified class with `count` parameters or Nil if there
		  /// isn't one.
		  
		  // Look for the zero parameter constructor (there must be one for custom classes to be encodable).
		  For Each constructor As Introspection.ConstructorInfo In ti.GetConstructors
		    Var params() As Introspection.ParameterInfo = constructor.GetParameters
		    If params.Count = count Then
		      Return constructor
		    End If
		  Next constructor
		  
		  // There is no constructor with this many parameters.
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520706C6174666F726D2074686973206170702069732072756E6E696E67206F6E2E
		Private Function CurrentPlatform() As EncodeKit.Platforms
		  /// Returns the platform this app is running on.
		  
		  If TargetMacOS Then
		    Return Platforms.macOS
		    
		  ElseIf TargetWindows Then
		    Return Platforms.Windows
		    
		  ElseIf TargetIOS Then
		    Return Platforms.iOS
		    
		  ElseIf TargetAndroid Then
		    Return Platforms.Android
		    
		  ElseIf TargetLinux Then
		    Return Platforms.Linux
		    
		  Else
		    Raise New UnsupportedOperationException("Running on an unknown platform.")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732054727565206966207468652073706563696669656420636C61737320686173206120636F6E7374727563746F7220776974682060636F756E746020706172616D65746572732E
		Function HasConstructorWithParameterCount(Extends ti As Introspection.TypeInfo, count As Integer) As Boolean
		  /// Returns True if the specified class has a constructor with `count` parameters.
		  
		  For Each constructor As Introspection.ConstructorInfo In ti.GetConstructors
		    Var params() As Introspection.ParameterInfo = constructor.GetParameters
		    If params.Count = count Then
		      Return True
		    End If
		  Next constructor
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526567697374657273206120636C61737320736F20746861742069742063616E20626520656E636F6465642F6465636F6465642E2057696C6C20726169736520616E20496E76616C6964417267756D656E74457863657074696F6E2069662074686520636C6173732063616E6E6F7420626520726567697374657265642E
		Sub RegisterClass(ti As Introspection.TypeInfo)
		  /// Registers a class so that it can be encoded/decoded.
		  /// Will raise an InvalidArgumentException if the class cannot be registered.
		  ///
		  /// Classes must be registered ahead of time because there is no way to get type info at runtime
		  /// from a string so we need to declare in advance.
		  
		  // Encodable classes must have a zero parameter constructor unless they are a special case.
		  If Not ti.HasConstructorWithParameterCount(0) And Not ZeroConstructorParamExceptions.HasKey(ti.FullName) Then
		    Raise New InvalidArgumentException("Cannot encode classes which do not have a zero parameter constructor (" + ti.FullName + ").")
		  End If
		  
		  // OK to register.
		  RegisteredClasses.Value(ti.FullName) = ti
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F6620612060506C6174666F726D736020656E756D65726174696F6E2E
		Private Function ToString(Extends platform As EncodeKit.Platforms) As String
		  /// Returns a string representation of a `Platforms` enumeration.
		  
		  Select Case platform
		  Case Platforms.Android
		    Return "Android"
		    
		  Case Platforms.iOS
		    Return "iOS"
		    
		  Case Platforms.Linux
		    Return "Linux"
		    
		  Case Platforms.macOS
		    Return "macOS"
		    
		  Case Platforms.Windows
		    Return "Windows"
		    
		  Else
		    Raise New InvalidArgumentException("Unknown EncodeKit.Platforms enumeration.")
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076657273696F6E206E756D62657220696E2053656D56657220666F726D61743A20226D616A6F722E6D696E6F722E7061746368222E
		Protected Function Version() As String
		  /// Returns the version number in SemVer format: "major.minor.patch".
		  
		  Return VERSION_MAJOR.ToString + "." + _
		  VERSION_MINOR.ToString + "." + VERSION_PATCH.ToString
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Credits
		This is essentially a modern port of Kem Tekinay's proof-of-concept Serializer_MTC class:
		
		https://github.com/ktekinay/Data-Serialization/
		
		EncodeKit differs in the following ways:
		
		- Separate encoder and decoder classes.
		- API 2.0.
		- Removed all references to Xojo.Data and Xojo.Core namespaces.
		- Removed the need for Text and Auto datatypes.
		- Removed support for Date
		- Added support for DateTime, TimeZone and FolderItem encoding
		
		
	#tag EndNote

	#tag Note, Name = Limitations
		Custom classes to be encoded must have a zero-parameter constructor. This does not have
		to be a public constructor. This is needed so the decoder can create a "blank" instance of that
		class before using introspection to set its properties.
		
		
	#tag EndNote

	#tag Note, Name = Usage
		Before you can encode a custom class, you must first register it with EncodeKit.
		There is no need to register Xojo primitives or other common built-in classes such as
		Dictionary, FolderItem and JSONItem as they are handled internally.
		
		The below example shows how to register a class called MyClass. This is best done 
		in `App.Opening()` but must be done before any encoding takes place:
		
		```xojo
		EncodeKit.RegisterClass GetTypeInfo(MyClass)
		```
		
		To encode an instance of MyClass:
		
		```xojo
		Var encoder As New EncodeKit.JSONEncoder
		Var c1 As New MyClass
		Var json As String = encoder.Encode(c1)
		```
		
		To decode an instance of MyClass:
		
		```xojo
		Var decoder As New EncodeKit.JSONDecoder
		Var c1 As MyClass = decoder.Decode(json)
		```
		
		
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 54686520637573746F6D20636C617373657320746861742068617665206265656E2072656769737465726564207769746820456E636F64654B697420746F20626520656E636F6465642F6465636F6465642E204B6579203D20636C617373206E616D652028537472696E67292C2056616C7565203D2054797065496E666F2E
		Private mRegisteredClasses As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mZeroConstructorParamExceptions As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 54686520637573746F6D20636C617373657320746861742068617665206265656E2072656769737465726564207769746820456E636F64654B697420746F20626520656E636F6465642F6465636F6465642E204B6579203D20636C617373206E616D652028537472696E67292C2056616C7565203D2054797065496E666F2E
		#tag Note
			Needed by DecodeObject()
		#tag EndNote
		#tag Getter
			Get
			  If mRegisteredClasses Is Nil Then
			    mRegisteredClasses = New Dictionary
			    
			    // Special cases.
			    RegisterClass GetTypeInfo(CriticalSection)
			    RegisterClass GetTypeInfo(DateTime)
			    RegisterClass GetTypeInfo(Dictionary)
			    RegisterClass GetTypeInfo(FolderItem)
			    RegisterClass GetTypeInfo(JSONItem)
			    RegisterClass GetTypeInfo(TimeZone)
			  End If
			  
			  Return mRegisteredClasses
			  
			End Get
		#tag EndGetter
		Private RegisteredClasses As Dictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21, Description = 4B6579203D2046756C6C206E616D652028537472696E6729206F6620636C6173732074686174206973206578656D70742066726F6D2074686520226E6F207A65726F20706172616D6574657220636F6E7374727563746F72222072756C652E2056616C756520697320616C77617973204E696C2028756E75736564292E
		#tag Getter
			Get
			  If mZeroConstructorParamExceptions = Nil Then
			    
			    mZeroConstructorParamExceptions = New Dictionary
			    
			    // Register the special cases that don't require zero parameter constructors to encode.
			    mZeroConstructorParamExceptions.Value("DateTime") = Nil
			    mZeroConstructorParamExceptions.Value("Dictionary") = Nil
			    mZeroConstructorParamExceptions.Value("JSONItem") = Nil
			    mZeroConstructorParamExceptions.Value("TimeZone") = Nil
			    
			  End If
			  
			  Return mZeroConstructorParamExceptions
			End Get
		#tag EndGetter
		Private ZeroConstructorParamExceptions As Dictionary
	#tag EndComputedProperty


	#tag Constant, Name = VERSION_MAJOR, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = VERSION_MINOR, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = VERSION_PATCH, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = Platforms, Type = Integer, Flags = &h21
		Android
		  Linux
		  iOS
		  macOS
		Windows
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
