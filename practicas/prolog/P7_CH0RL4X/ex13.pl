%inorder(+AB,-Lista)
inorder(nil, []).
inorder(bin(I, R, D), L) :- inorder(I, Li), inorder(D, Ld), append(Li, [R|Ld], L).
