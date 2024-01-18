#tag Class
Protected Class Class1
	#tag Property, Flags = &h0
		BooleanProp As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Class2Array() As Class2
	#tag EndProperty

	#tag Property, Flags = &h0
		Class2Prop As Class2
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 476574732F73657473207468652076616C7565206F66206D50726976617465496E742E
		#tag Getter
			Get
			  Return mPrivateInt
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mPrivateInt = value
			  
			End Set
		#tag EndSetter
		ComputedInt As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		DateTimeArray() As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		DictionaryProp As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		DoubleArray() As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		DoubleProp As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		IntArray() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		IntegerProp As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateInt As Integer = 10
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProtectedString As String = "Protected String"
	#tag EndProperty

	#tag Property, Flags = &h0
		StringArray() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		StringProp As String = "DefaultStringProp"
	#tag EndProperty


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
			Name="ComputedInt"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StringProp"
			Visible=false
			Group="Behavior"
			InitialValue="DefaultStringProp"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IntegerProp"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleProp"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BooleanProp"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
