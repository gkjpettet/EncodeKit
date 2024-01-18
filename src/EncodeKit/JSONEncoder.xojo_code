#tag Class
Protected Class JSONEncoder
	#tag Method, Flags = &h0, Description = 456E636F6465732074686520706173736564206F626A65637420696E746F2061204A534F4E20737472696E672E
		Function Encode(v As Variant) As String
		  /// Encodes the passed object into a JSON string.
		  
		  v = ToJSONStorable(v, "")
		  
		  Var s As String = GenerateJSON(v)
		  
		  If Not Compact Then
		    
		    Var ji As New JSONItem(s)
		    ji.Compact = False
		    Return ji.ToString
		    
		  Else
		    
		    Return s
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456E636F6465732061727261792060766020696E746F20612044696374696F6E6172792077686963682063616E207468656E20626520636F6E76657274656420746F204A534F4E2E206070726F705479706560206973207468652074797065206F662061727261792E206022226020617373756D657320604F626A6563742829602E
		Private Function EncodeArray(v As Variant, propType As String) As Dictionary
		  /// Encodes array `v` into a Dictionary which can then be converted to JSON.
		  /// `propType` is the type of array. `""` assumes `Object()`.
		  ///
		  /// WARNING: All the possible array types are not represented
		  
		  // Create the root dictionary to return. This will inform the decoder that this is an array.
		  Var root As New Dictionary
		  root.Value(KEY_TYPE) = "Array"
		  
		  Var properties As New Dictionary
		  root.Value(KEY_PROPERTIES) = properties
		  
		  Var elements() As Variant
		  properties.Value(KEY_ARRAY_ELEMENTS) = elements
		  
		  // Determine the type of array it is.
		  Var elementType As Integer = v.ArrayElementType
		  If propType = "" And elementType = Variant.TypeObject Then
		    propType = "Object()"
		  End If
		  
		  Select Case elementType
		  Case Variant.TypeBoolean
		    root.Value(KEY_ARRAY_TYPE) = "Boolean()"
		    properties.Value(KEY_ARRAY_ELEMENTS) = v
		    
		  Case Variant.TypeColor
		    root.Value(KEY_ARRAY_TYPE) = "Color()"
		    Var arr() As color = v
		    For i As Integer = 0 To arr.LastIndex
		      Var c As Color = arr(i)
		      elements.Add(EncodeColor(c))
		    Next
		    
		  Case Variant.TypeCurrency
		    root.Value(KEY_ARRAY_TYPE) = "Currency()"
		    Var arr() As Currency = v
		    For i As Integer = 0 To arr.LastIndex
		      elements.Add(arr(i))
		    Next
		    
		  Case Variant.TypeDouble
		    root.Value(KEY_ARRAY_TYPE) = "Double()"
		    properties.Value(KEY_ARRAY_ELEMENTS) = v
		    
		  Case Variant.TypeInt32
		    root.Value(KEY_ARRAY_TYPE) = "Int32()"
		    properties.Value(KEY_ARRAY_ELEMENTS) = v
		    
		  Case Variant.TypeInt64
		    root.Value(KEY_ARRAY_TYPE) = "Int64()"
		    properties.Value(KEY_ARRAY_ELEMENTS) = v
		    
		  Case Variant.TypeSingle
		    root.Value(KEY_ARRAY_TYPE) = "Single()"
		    properties.Value(KEY_ARRAY_ELEMENTS) = v
		    
		  Case Variant.TypeString
		    root.Value(KEY_ARRAY_TYPE) = "String()"
		    properties.Value(KEY_ARRAY_ELEMENTS) = v
		    
		  Case Variant.TypeText
		    root.Value(KEY_ARRAY_TYPE) = "Text()"
		    properties.Value(KEY_ARRAY_ELEMENTS) = v
		    
		  Case Else
		    root.Value(KEY_ARRAY_TYPE) = "Variant()"
		    Var arr() As Variant = v
		    For i As Integer = 0 To arr.LastIndex
		      elements.Add(ToJSONStorable(arr(i), ""))
		    Next i
		  End Select
		  
		  Return root
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456E636F646573206120436F6C6F7220746F20612064696374696F6E61727920736F2069742063616E2062652073756273657175656E746C7920636F6E76657274656420746F204A534F4E2E
		Private Function EncodeColor(c As Color) As Dictionary
		  /// Encodes a Color to a dictionary so it can be subsequently converted to JSON.
		  
		  Var root As New Dictionary
		  
		  root.Value(KEY_TYPE) = "Color"
		  
		  Var properties As New Dictionary
		  root.Value(KEY_PROPERTIES) = properties
		  
		  properties.Value("Red") = c.Red
		  properties.Value("Green") = c.Green
		  properties.Value("Blue") = c.Blue
		  properties.Value("Alpha") = c.Alpha
		  
		  Return root
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456E636F64657320612044696374696F6E6172792E
		Private Function EncodeDictionary(dict As Dictionary) As Dictionary
		  /// Encodes a Dictionary.
		  
		  Var root As New Dictionary
		  root.Value(KEY_TYPE) = "Dictionary"
		  
		  Var propertiesDict As New Dictionary
		  root.Value(KEY_PROPERTIES) = propertiesDict
		  
		  Var keysChild() As Variant
		  propertiesDict.Value(KEY_KEYS) = keysChild
		  
		  Var valuesChild() As Variant
		  propertiesDict.Value(KEY_VALUES) = valuesChild
		  
		  Var keys() As Variant = dict.Keys
		  Var values() As Variant = dict.Values
		  For i As Integer = 0 To keys.LastIndex
		    Var key As Variant = keys(i)
		    Var value As Variant = values(i)
		    
		    key = ToJSONStorable(key, "")
		    value = ToJSONStorable(value, "")
		    
		    keysChild.Add(key)
		    valuesChild.Add(value)
		  Next i
		  
		  Return root
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76657274732061204A534F4E4974656D20746F206F757220656E636F64656420666F726D61742E
		Private Function EncodeJSONItem(j As JSONItem) As Dictionary
		  /// Converts a JSONItem to our encoded format.
		  
		  Var root As New Dictionary
		  root.Value(KEY_TYPE) = Introspection.GetType(j).FullName
		  
		  Var propsChild As New Dictionary
		  root.Value(KEY_PROPERTIES) = propsChild
		  
		  Var s As String = j.ToString
		  Var count As Integer = j.Count
		  
		  propsChild.Value(KEY_JSON_STRING_VALUE) = s
		  propsChild.Value(KEY_JSON_COUNT) = count
		  
		  Return root
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456E636F6465732074686520706173736564206F626A65637420746F20612044696374696F6E6172792077686963682063616E207468656E2073756273657175656E746C7920626520656E636F64656420746F204A534F4E206279206047656E65726174654A534F4E2829602E
		Private Function EncodeObject(o As Object) As Dictionary
		  /// Encodes the passed object to a Dictionary which can then subsequently be
		  /// encoded to JSON by `GenerateJSON()`.
		  
		  Var root As Dictionary
		  
		  If o Is Nil Then Return Nil
		  
		  // Get all of the properties via introspection.
		  // The structure will be:
		  //    Type: FullName
		  //    Properties:
		  //      PropName: Value
		  
		  // Get type information on this object.
		  Var ti As Introspection.TypeInfo = Introspection.GetType(o)
		  
		  // Assert that this is a registered class.
		  If Not RegisteredClasses.HasKey(ti.FullName) Then
		    Raise New UnsupportedFormatException("Cannot encode a class that has not been registered.")
		  End If
		  
		  Var propertiesDict As Dictionary
		  If o IsA Dictionary Then
		    root = EncodeDictionary(Dictionary(o))
		    propertiesDict = root.Value(KEY_PROPERTIES)
		    
		  ElseIf o IsA JSONItem Then
		    root = EncodeJSONItem(JSONItem(o))
		    propertiesDict = root.Value(KEY_PROPERTIES)
		    
		  Else
		    root = New Dictionary
		    propertiesDict = New Dictionary
		    root.Value(KEY_PROPERTIES) = propertiesDict
		    
		  End If
		  
		  // Set the type of this object.
		  root.Value(KEY_TYPE) = ti.FullName
		  
		  Var properties() As Introspection.PropertyInfo = ti.GetProperties
		  For Each prop As Introspection.PropertyInfo In properties
		    If Not prop.CanRead Or Not prop.CanWrite Then
		      // We only want properties that we can read and write back later.
		      Continue For prop
		    End If
		    
		    If prop.PropertyType.Name = "WeakRef" Then
		      // Don't restore weak references as they will always be invalid when decoding.
		      Continue For prop
		    End If
		    
		    If prop.IsComputed And Not IncludeComputed Then
		      Continue For prop
		    End If
		    
		    If prop.IsProtected And Not IncludeProtected Then
		      Continue For prop
		    End If
		    
		    If prop.IsPrivate And Not IncludePrivate Then
		      Continue For prop
		    End If
		    
		    // Get this property's value.
		    Var value As Variant = prop.Value(o)
		    
		    // Encode the property's value to something `GenerateJSON()` can handle.
		    value = ToJSONStorable(value, prop.PropertyType.Name)
		    propertiesDict.Value(prop.Name) = value
		  Next prop
		  
		  // Special cases.
		  Select Case o
		  Case IsA DateTime
		    Var dt As DateTime = DateTime(o)
		    propertiesDict.Value("SecondsFrom1970") = dt.SecondsFrom1970
		    propertiesDict.Value("TimeZone") = EncodeObject(dt.Timezone)
		    
		  Case IsA FolderItem
		    Var f As FolderItem = FolderItem(o)
		    // We need the path to reconstruct a FolderItem and we'll also store the platform
		    // this FolderItem was encoded on as that impacts the format of the native path.
		    propertiesDict.RemoveAll
		    propertiesDict.Value("NativePath") = f.NativePath
		    propertiesDict.Value("Platform") = CurrentPlatform.ToString
		    
		  Case IsA TimeZone
		    Var tz As TimeZone = TimeZone(o)
		    propertiesDict.Value("SecondsFromGMT") = tz.SecondsFromGMT
		  End Select
		  
		  Return root
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320616E206F626A65637420746861742063616E20626520636F6E76657274656420746F204A534F4E206279206047656E65726174654A534F4E2829602E
		Private Function ToJSONStorable(v As Variant, propType As String) As Variant
		  /// Returns an object that can be converted to JSON by `GenerateJSON()`.
		  ///
		  /// `propType` is used internally when converting arrays.
		  
		  If v Is Nil Or v.IsNull Then
		    Return Nil
		  End If
		  
		  Var type As Integer = v.Type
		  If propType = "" And type >= 4096 Then
		    type = Variant.TypeArray
		  End If
		  
		  Select Case type
		  Case Variant.TypeColor
		    Return EncodeColor(v.ColorValue)
		    
		  Case Variant.TypeDateTime, Variant.TypeObject
		    Return EncodeObject(v)
		    
		  Case Variant.TypeArray
		    Return EncodeArray(v, propType)
		    
		  Case Else
		    If propType.Right(2) = "()" Then
		      Return EncodeArray(v, propType)
		    Else
		      Return v
		    End If
		  End Select
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 49662054727565207468656E20746865204A534F4E206F75747075742077696C6C2068617665206E6F20756E6E656365737361727920776869746573706163652E2049662046616C7365207468656E20746865206F75747075742077696C6C20696E636C7564652073706163657320616E64206C696E6520656E64696E677320656D62656464656420746F206D616B652074686520737472696E67206D6F7265207265616461626C652E
		Compact As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E20636F6D70757465642070726F706572746965732077696C6C20626520656E636F6465642E
		IncludeComputed As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E20707269766174652070726F706572746965732077696C6C20626520656E636F6465642E
		IncludePrivate As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2070726F7465637465642070726F706572746965732077696C6C20626520656E636F6465642E
		IncludeProtected As Boolean = True
	#tag EndProperty


	#tag Constant, Name = KEY_ARRAY_ELEMENTS, Type = String, Dynamic = False, Default = \"Elements", Scope = Private
	#tag EndConstant

	#tag Constant, Name = KEY_ARRAY_TYPE, Type = String, Dynamic = False, Default = \"Array Type", Scope = Private, Description = 53746F726573207468652074797065206F66206172726179207468617420697320656E636F6465642028652E673A2022496E743332282922292E
	#tag EndConstant

	#tag Constant, Name = KEY_JSON_COUNT, Type = String, Dynamic = False, Default = \"Count", Scope = Private
	#tag EndConstant

	#tag Constant, Name = KEY_JSON_STRING_VALUE, Type = String, Dynamic = False, Default = \"String Value", Scope = Private
	#tag EndConstant

	#tag Constant, Name = KEY_KEYS, Type = String, Dynamic = False, Default = \"Keys", Scope = Private
	#tag EndConstant

	#tag Constant, Name = KEY_PROPERTIES, Type = String, Dynamic = False, Default = \"Properties", Scope = Private
	#tag EndConstant

	#tag Constant, Name = KEY_TYPE, Type = String, Dynamic = False, Default = \"Type", Scope = Private
	#tag EndConstant

	#tag Constant, Name = KEY_VALUES, Type = String, Dynamic = False, Default = \"Values", Scope = Private
	#tag EndConstant


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
		#tag ViewProperty
			Name="Compact"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IncludeComputed"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IncludePrivate"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IncludeProtected"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
