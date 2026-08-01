<?php
defined('_JEXEC') or die;

use Joomla\CMS\Factory;
use Joomla\CMS\Router\Route;
use Joomla\CMS\Plugin\CMSPlugin;

class PlgSystemVisformsredirect extends CMSPlugin
{
    public function onAfterRoute()
    {
        $app = Factory::getApplication();

        if ($app->isClient('administrator')) {
            return;
        }

        $input  = $app->input;
        $option = $input->getCmd('option');
        $view   = $input->getCmd('view');
        $task   = $input->getCmd('task');

        // Do NOT redirect during logout
        if (
            ($option === 'com_users' && $task === 'user.logout') ||
            ($option === 'com_users' && $view === 'login' && $input->getCmd('layout') === 'logout')
        ) {
            return;
        }

        $user = Factory::getUser();
        if ($user->guest) {
            return;
        }

        $formId     = 18;
        $menuItemId = 181;

        // Check if user already has a record
        $db = Factory::getDbo();
        $query = $db->getQuery(true)
            ->select('id')
            ->from('#__visforms_18')
            ->where('created_by = ' . (int) $user->id)
            ->setLimit(1);

        $db->setQuery($query);
        $recordId = $db->loadResult();

        if (!$recordId) {
            return;
        }

        // Only redirect when user tries to access the FORM view
        if (!($option === 'com_visforms' && $view === 'visforms' && $input->getInt('id') == $formId)) {
            return;
        }

        // Build redirect URL
        $redirectUrl = Route::_(
            'index.php?option=com_visforms&view=visformsdata&layout=dataeditlist&id='
            . $formId . '&Itemid=' . $menuItemId,
            false
        );

        $app->redirect($redirectUrl);
    }
}
