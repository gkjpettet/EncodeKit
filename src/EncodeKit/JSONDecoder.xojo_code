#tag Class
Protected Class JSONDecoder
	#tag Method, Flags = &h0, Description = 4465636F6465732061207072696D6974697665206F72207265676973746572656420636C617373206F626A6563742066726F6D2074686520706173736564204A534F4E2E
		Function Decode(json As String) As Variant
		  /// Decodes a primitive or registered class object from the passed JSON.
		  
		  Var d As Dictionary = ParseJSON(json)
		  
		  Var v As Variant = FromParsedJSON(d)
		  
		  Return v
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4465636F64657320746865206172726179207468617420686173206265656E20656E636F64656420696E746F20746865207061737365642044696374696F6E6172792E
		Private Function DecodeArray(root As Dictionary) As Variant
		  /// Decodes the array that has been encoded into the passed Dictionary.
		  ///
		  /// WARNING: All the possible array types are not represented
		  
		  Var type As String = root.Value(KEY_ARRAY_TYPE)
		  Var properties As Dictionary = root.Value(KEY_PROPERTIES)
		  Var elements() As Variant = properties.Value(KEY_ARRAY_ELEMENTS)
		  
		  Select Case type
		  Case "Boolean()"
		    Var arr() As Boolean
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "Color()"
		    Var arr() As Color
		    For i As Integer = 0 To elements.LastIndex
		      Var value As Variant = elements(i)
		      value = FromParsedJSON(value)
		      arr.Add(value)
		    Next i
		    
		    Return arr
		    
		  Case "Double()"
		    Var arr() As Double
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "Integer()"
		    Var arr() As Integer
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "Int8()"
		    Var arr() As Int8
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "Int16()"
		    Var arr() As Int16
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "Int32()"
		    Var arr() As Int32
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "Int64()"
		    Var arr() As Int64
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "Object()"
		    Var arr() As Object
		    For i As Integer = 0 To elements.LastIndex
		      Var value As Variant = elements(i)
		      value = FromParsedJSON(value)
		      arr.Add(value)
		    Next i
		    
		    Return arr
		    
		  Case "Single()"
		    Var arr() As Single
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "String()"
		    Var arr() As String
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "UInt8()"
		    Var arr() As UInt8
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "UInt16()"
		    Var arr() As UInt16
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "UInt32()"
		    Var arr() As UInt32
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "UInt64()"
		    Var arr() As UInt64
		    For i As Integer = 0 To elements.LastIndex
		      arr.Add(elements(i))
		    Next i
		    
		    Return arr
		    
		  Case "Variant()"
		    Var arr() As Variant
		    For i As Integer = 0 To elements.LastIndex
		      Var value As Variant = elements(i)
		      value = FromParsedJSON(value)
		      arr.Add(value)
		    Next i
		    
		    Return arr
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4465636F646573206120436F6C6F72206F626A65637420746F206120436F6C6F72207072696D69746976652E
		Private Function DecodeColor(properties As Dictionary) As Color
		  /// Decodes a Color object to a Color primitive.
		  
		  Var r As Integer = properties.Value("Red")
		  Var g As Integer = properties.Value("Green")
		  Var b As Integer = properties.Value("Blue")
		  Var a As Integer = properties.Value("Alpha")
		  
		  Return Color.RGB(r, g, b, a)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4465636F64657320616E20656E636F6465642044696374696F6E617279207769746820746865207370656369666965642070726F706572746965732E
		Private Sub DecodeDictionary(properties As Dictionary, d As Dictionary)
		  /// Decodes an encoded Dictionary with the specified properties.
		  
		  Var keysChild() As Variant = properties.Value(KEY_KEYS)
		  Var valuesChild() As Variant = properties.Value(KEY_VALUES)
		  
		  For i As Integer = 0 To keysChild.LastIndex
		    Var key As Variant = keysChild(i)
		    Var value As Variant = valuesChild(i)
		    
		    key = FromParsedJSON(key)
		    value = FromParsedJSON(value)
		    
		    d.Value(key) = value
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4465636F64657320616E206F626A65637420746861742077617320656E636F64656420696E746F20612044696374696F6E617279206279204A534F4E456E636F6465722E
		Private Function DecodeObject(root As Dictionary) As Object
		  /// Decodes an object that was encoded into a Dictionary by JSONEncoder.
		  
		  If root Is Nil Then Return Nil
		  
		  Var r As Object
		  
		  // Get the object's properties.
		  Var propertiesDict As Dictionary = root.Value(KEY_PROPERTIES)
		  
		  // Get the object's type.
		  Var type As String = root.Value(KEY_TYPE)
		  
		  // We have to figure out what class it is and create a new one
		  Var ti As Introspection.TypeInfo = RegisteredClasses.Lookup(type, Nil)
		  If ti Is Nil Then
		    Raise New UnsupportedFormatException("Cannot decode a class that has not been registered.")
		  End If
		  
		  // Special case: FolderItems.
		  If type = "FolderItem" Then
		    r = New FolderItem(propertiesDict.Value("NativePath"), FolderItem.PathModes.Native)
		    Return r
		  End If
		  
		  // Look for the zero parameter constructor (there must be one for custom classes to be encodable).
		  Var constructor As Introspection.ConstructorInfo = ti.ConstructorWithParameterCount(0)
		  If constructor <> Nil Then
		    r = constructor.Invoke
		  End If
		  
		  If r Is Nil Then
		    If type = "Dictionary" Then
		      r = New Dictionary
		      
		    ElseIf type = "JSONItem" Then
		      r = New JSONItem
		      
		    ElseIf type = "DateTime" Then
		      // Return a new DateTime object.
		      // We do this here because there is no zero parameter DateTime constructor.
		      Var secondsFrom1970 As Integer = propertiesDict.Value("SecondsFrom1970")
		      Var tz As TimeZone
		      Var tzDict As Dictionary = propertiesDict.Lookup("TimeZone", Nil)
		      If tzDict <> Nil Then
		        Var tzProps As Dictionary = tzDict.Value(KEY_PROPERTIES)
		        Var secondsFromGMT As Integer = tzProps.Value("SecondsFromGMT")
		        tz = New TimeZone(secondsFromGMT)
		      End If
		      Return New DateTime(secondsFrom1970, tz)
		      
		    Else
		      Raise New UnsupportedFormatException("Could not find a zero parameter constructor for type `" + type + "`.")
		    End If
		  End If
		  
		  Var properties() As Introspection.PropertyInfo = ti.GetProperties
		  For Each prop As Introspection.PropertyInfo In properties
		    // Make sure we can write this property.
		    If Not prop.CanWrite Then
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
		    
		    // Make sure this property is in the properties list.
		    If Not propertiesDict.HasKey(prop.Name) Then
		      Continue For prop
		    End If
		    
		    // Get the (decoded) value of this property.
		    Var value As Variant = propertiesDict.Value(prop.Name)
		    value = FromParsedJSON(value)
		    
		    // If this is an array of objects, cycle through them.
		    Var valueType As Integer = value.Type
		    Var elementType As Integer = If(valueType >= 4096, valueType - 4096, -1)
		    If elementType = Variant.TypeObject Then
		      Var o() As Object = value
		      Var a As Variant = prop.Value(r)
		      Var dest() As Object = a
		      For i As Integer = 0 To o.LastIndex
		        dest.Add(o(i))
		      Next i
		    Else
		      prop.Value(r) = value
		    End If
		  Next prop
		  
		  // Special cases.
		  If r IsA Dictionary Then
		    DecodeDictionary(propertiesDict, Dictionary(r))
		    
		  ElseIf r IsA JSONItem Then
		    Var j As JSONItem = JSONItem(r)
		    j.Load(propertiesDict.Value(KEY_JSON_STRING_VALUE))
		  End If
		  
		  Return r
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120706172736564204A534F4E2076616C756520616E6420636F6E766572747320697420746F20616E206F626A656374206966206E65656465642E
		Private Function FromParsedJSON(v As Variant) As Variant
		  /// Returns a parsed JSON value and converts it to an object if needed.
		  
		  If v Is Nil Or v.IsNull Then Return Nil
		  
		  If v IsA Dictionary Then
		    Var d As Dictionary = Dictionary(v.ObjectValue)
		    Var type As String = d.Value(KEY_TYPE)
		    
		    Select Case type
		    Case "Color"
		      Return DecodeColor(d.Value(KEY_PROPERTIES))
		      
		    Case "Array"
		      Return DecodeArray(d)
		      
		    Case Else
		      Return DecodeObject(d)
		    End Select
		    
		  Else
		    Return v
		  End If
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 49662054727565207468656E20636F6D70757465642070726F706572746965732077696C6C206265206465636F6465642E
		IncludeComputed As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E20707269766174652070726F706572746965732077696C6C206265206465636F6465642E
		IncludePrivate As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2070726F7465637465642070726F706572746965732077696C6C206265206465636F6465642E
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
