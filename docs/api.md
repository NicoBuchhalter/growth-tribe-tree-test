Trees API - Documentation
===============

### Getting a whole tree structure

``` 
GET /trees/:tree_id
```

In case the tree exists, the answer will have a status code 200 and a body like this: 

```json
{
    "id": 1158,
    "child": [
        {
            "id": 6001,
            "child": []
        },
        {
            "id": 575,
            "child": []
        }
    ]
}
```

Otherwise, it will respond with a status code 400.

### Getting the IDs of the ancestors of a node in a specified tree

``` 
GET /trees/:tree_id/parent/:tree_node_id
```

In case the tree and the node in it exist, the answer will have a status code 200 and a body like this: 

```json
{
    "parent_ids": [
        1,
        7130
    ]
}
```

Otherwise, it will respond with a status code 400. There will be a message indicating if it was the tree or the node the one which was not found.

### Getting the subtree of a node in a specific tree

``` 
GET /trees/:tree_id/child/:tree_node_id
```

In case the tree and the node in it exist, the answer will have a status code 200 and a body with same structure than the whole tree, but having the requested node as a root.

Otherwise, it will respond with a status code 400. There will be a message indicating if it was the tree or the node the one which was not found.

