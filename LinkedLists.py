class Node():
	def __init__(self,data = None):
		self.data = data
		self.next = None

class LinkedList():
	def __init__(self):
		self.head = None

	def add_node(self, data):
		curr = self.head

		if curr == None:
			self.head = Node(data)
		else:
			while curr.next != None:
				curr = curr.next
			curr.next = Node(data)

	def display_elements(self):
		curr = self.head
		list_linked = []
		if curr == None:
			print ('No data exist in the Linked List')
		else:
			list_linked.append(curr.data)
			while curr.next != None:
				list_linked.append(curr.next.data)
				curr = curr.next
			print(list_linked)

	def remove_element(self, data):
		curr = self.head
		next_val = curr.next
		if curr.data == data:
			self.head = next_val
			return
		while True:
			last = curr
			curr = curr.next
			if curr.data == data:
				last.next = curr.next
				return


Linked_List = LinkedList()

Linked_List.add_node(2)
Linked_List.add_node(5)
Linked_List.add_node(7)
Linked_List.add_node(1)

print('---After Addition---')
Linked_List.display_elements()
print('')

Linked_List.remove_element(2)
print('---After Removal of 2---')
Linked_List.display_elements()
