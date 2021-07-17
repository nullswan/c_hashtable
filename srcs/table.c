/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   table.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: c3b5aw <dev@c3b5aw.dev>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/07/17 21:47:20 by c3b5aw            #+#    #+#             */
/*   Updated: 2021/07/17 23:02:51 by c3b5aw           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/hashtable_item.h"
#include "../includes/hashtable_types.h"

/**
 * * hashtable_new
 *  
 * Allocate space for a new hashtable object.
 * >	return (NULL) on fail.
 * Allocate space for each hashtable item. 
 * > 	return (NULL) on fail.
 * 
 * @param	size 	(unsigned int)		size of the hashtable
 * 
 * @return			(hashtable_t *)		a new hashtable object
 *
**/
t_hashtable	*hashtable_new(unsigned int size)
{
	t_hashtable		*ret;
	unsigned int	i;

	ret = (t_hashtable *)malloc(sizeof(t_hashtable));
	if (!ret)
		return (0);
	ret->size = size;
	ret->count = 0;
	ret->items = (t_hashtable_item **)malloc(sizeof(t_hashtable_item *) * size);
	if (!ret->items)
	{
		free(ret);
		return (0);
	}
	i = -1;
	while (++i < ret->size)
		ret->items[i] = 0;
	return (ret);
}

/**
 * * hashtable_destroy
 * 
 * Destroy hashtable by iterating over all elements and freeing them. 
 * 
 * @param table	(t_hashtable *)		The hashtable to destroy
 * 
**/

void	hashtable_destroy(t_hashtable **table)
{
	t_hashtable_item	*item;
	unsigned int		i;

	if (!table || !(*table))
		return ;
	i = -1;
	while (++i < (*table)->size)
	{
		item = (*table)->items[i];
		if (item)
			hashtable_item_destroy(item);
	}
	free((*table)->items);
	free((*table));
	*table = 0;
}